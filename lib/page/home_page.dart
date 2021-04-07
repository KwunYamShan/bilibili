import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';

class HomePage extends StatefulWidget {

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  RouteChangeListener listener ;
  @override
  void initState() {
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
            Text('首页'),
            MaterialButton(
              onPressed: () => HiNavigator.getInstance().onJumpTo(RouteStatus.detail,args: {'videoMo':VideoModel(1111)}),
            child: Text('详情'),
            ),
          ],
        ),
      ),
    );
  }
}
