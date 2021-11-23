import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_state.dart';
import 'package:flutter_bilibili/http/api/home_api.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/home_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/page/profile_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/util/color_util.dart';
import 'package:flutter_bilibili/util/toast_util.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/loading_container.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {
  final ValueChanged<int>? onJumpTo;

  const HomePage({Key? key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//WidgetsBindingObserver生命周期监听 addObserver  didChangeAppLifecycleState
class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  var listener;

  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];

  bool _isloading = true; //因为第一次肯定是要加载数据的

  Widget? _currentPage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(this.listener = (current, pre) {
      print("current:${current.page}  ,pre:${pre.page}");
      if (widget == current.page || current.page is HomePage) {
        print("打开了首页：onResume");
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print("首页onPause");
      }
      //当页面返回到首页恢复首页的状态栏样式    视频详情页并且不是个人中心页面
      if (pre?.page is VideoDetailPage && !(current.page is ProfilePage)) {
        // var statusStyle = StatusStyle.DARK_CONTENT;
        changeStatusBar();
      }
    });
    loadData();
  }

  @override
  void dispose() {
    HiNavigator.getInstance().removeListener((current, pre) => listener);
    _controller.dispose();
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  //监听应用生命周期变化
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.inactive: //处于这种状态的应用程序应该假设它们可能在任何时候暂停
        break;
      case AppLifecycleState.resumed: //从后台切换前台，界面可见
      //fix 后台重新变前台 状态栏字体颜色变白的问题
          changeStatusBar();
        break;
      case AppLifecycleState.paused: //进入后台，界面不可见
        break;
      case AppLifecycleState.detached: //app结束时调用
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:
        LoadingContainer(isLoading: _isloading, child: Container(
          child: Column(
            children: [
              NavigationBar(
                height: 50,
                color: Colors.white,
                child: appBar(),
                statusStyle: StatusStyle.DARK_CONTENT,
              ),
              Container(
                //color: Colors.white,       Failed assertion: line 275 pos 15: 'color == null || decoration == null'
                decoration: bottomBoxShadow(),
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
        ),)
    );
  }

  //页面切换不会重新创建
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  late TabController _controller;

  _tabbar() {
    return HiTab(categoryList.map<Tab>((tab) {
      return Tab(
          text: tab.name);
    }).toList(),
      controller: _controller,
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      insets: 13,
    );

  }

  //异步请求数据
  void loadData() async {
    _isloading = true;
    try {
      HomeMo result = await HomeApi.get('推荐');
      print('loadData:${result}');
      if (result.categoryList != null) {
        //contorller tab数量发生变化时 需要重新创建tabContorller
        _controller =
            TabController(length: result.categoryList.length, vsync: this);
      }

      //TODO 删除延时
      Future.delayed(Duration(milliseconds: 1000), () {
        setState(() {
          _isloading = false;
        });
      });
      categoryList = result.categoryList;
      bannerList = result.bannerList;
    } on NeedAuth catch (e) {
      setState(() {
        _isloading = false;
      });
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      setState(() {
        _isloading = false;
      });
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
              if (widget.onJumpTo != null) {
                widget.onJumpTo!(3);
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
            child: Icon(Icons.mail_outline, color: Colors.grey,),
          )
        ],
      ),
    );
  }
}
