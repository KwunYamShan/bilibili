import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_state.dart';
import 'package:flutter_bilibili/http/api/home_api.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/home_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/util/color_util.dart';
import 'package:flutter_bilibili/util/toast_util.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int> onJumpTo;
  const HomePage({Key key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  RouteChangeListener listener;

  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];

  @override
  void initState() {
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print("current:${current.page}  ,pre:${pre.page}");
      if (widget == current.page || current.page is HomePage) {
        print("打开了首页：onResume");
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print("首页onPause");
      }
    });
    super.initState();

    loadData();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener((current, pre) => listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            NavigationBar(
              height: 50,
              color: Colors.white,
              child: appBar(),
              statusStyle: StatusStyle.DARK_CONTENT,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 30),
              child: _tabbar(),
            ),
            Flexible(
                child: TabBarView(
              controller: _controller,
              children: categoryList.map((tab) {
                return HomeTabPage(
                  categoryName: tab.name,
                  bannerList: tab.name == '推荐' ? bannerList : null,
                );
              }).toList(),
            ))
          ],
        ),
      ),
    );
  }

  //页面切换不会重新创建
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  TabController _controller;

  _tabbar() {
    return TabBar(
        controller: _controller,
        isScrollable: true,
        //控制tabbar是否可以横向滚动
        labelColor: Colors.black,
        indicator: UnderlineIndicator(
          strokeCap: StrokeCap.round, //圆角
          borderSide: BorderSide(color: primary, width: 3),
          insets: EdgeInsets.only(left: 15, right: 15), //内边距
        ),
        tabs: categoryList.map<Tab>((tab) {
          return Tab(
            child: Padding(
              padding: EdgeInsets.only(left: 5, right: 5),
              child: Text(
                tab.name,
                style: TextStyle(fontSize: 16),
              ),
            ),
          );
        }).toList());
  }

  //异步请求数据
  void loadData() async {
    try {
      HomeMo result = await HomeApi.get('推荐');
      print('loadData:${result}');
      if (result.categoryList != null) {
        //contorller tab数量发生变化时 需要重新创建tabContorller
        _controller =
            TabController(length: result.categoryList.length, vsync: this);
      }
      setState(() {
        categoryList = result.categoryList;
        bannerList = result.bannerList;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              if(widget.onJumpTo !=null){
                widget.onJumpTo(3);
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(23),
              child: Image(
                height: 46,
                width: 46,
                image: AssetImage('images/avatar.png'),
              ),
            ),
          ),
          Expanded(
              child: Padding(
            //填充剩余空间
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          Icon(
            Icons.explore_outlined,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(Icons.mail_outline,color: Colors.grey,),
          )
        ],
      ),
    );
  }
}
