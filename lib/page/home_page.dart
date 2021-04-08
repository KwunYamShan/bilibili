import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/home_tab_page.dart';
import 'package:flutter_bilibili/util/color_util.dart';
import 'package:underline_indicator/underline_indicator.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>  with AutomaticKeepAliveClientMixin,TickerProviderStateMixin{
  RouteChangeListener listener ;
  var tabs = ["推荐",'热门',"追播",'影视',"搞笑",'日常',"综合",'手机游戏','短片-手书-配音'];
  @override
  void initState() {
    _controller = TabController(length: tabs.length, vsync: this);
    HiNavigator.getInstance().addListener( this.listener = (current,pre){
      print("current:${current.page}  ,pre:${pre.page}");
      if(widget == current.page   || current.page is HomePage){
        print("打开了首页：onResume");
      }else if( widget == pre?.page || pre?.page is HomePage){
        print("首页onPause");
      }
    });
    super.initState();
  }
  @override
  void dispose() {
    HiNavigator.getInstance().removeListener((current, pre) => listener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top:30),
              child: _tabbar(),
            ),
          Flexible(child: TabBarView(
            controller: _controller,
            children: tabs.map((tab){
              return HomeTabPage(title:tab);
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
        isScrollable: true,//控制tabbar是否可以横向滚动
        labelColor: Colors.black,
        indicator: UnderlineIndicator(
          strokeCap: StrokeCap.round,//圆角
          borderSide: BorderSide(color: primary,width: 3),
          insets: EdgeInsets.only(left: 15,right: 15),//内边距

        ),
        tabs: tabs.map<Tab>((tab){
          return Tab(
            child: Padding(
              padding: EdgeInsets.only(left: 5,right: 5),
              child: Text(tab,style: TextStyle(fontSize:16),),
            ),
          );
        }).toList());
  }
}
