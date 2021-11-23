import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/view_util.dart';

//三方库中有statusbar有该枚举，但是我们还需要自行定义 是为了以后更换第三方时降低耦合
enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

//可自定义样式的沉浸式导航栏
class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle;
  final Color color;
  final double height;
  final Widget? child;

  @override
  _NavigationBarState createState() => _NavigationBarState();

  const NavigationBar(
      {Key? key,
      this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = Colors.white,
      this.height = 46,
      this.child})
      : super(key: key);

}
class _NavigationBarState extends State<NavigationBar> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _statusBarInit();
  }
  @override
  Widget build(BuildContext context) {
    var top = MediaQuery.of(context).padding.top; //刘海屏幕 刘海的高度
    return Container(
      //状态栏高度
      width: MediaQuery.of(context).size.width,
      height: top + widget.height,
      //刘海下面导航条的高度
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: widget.color),
    );
  }
  void _statusBarInit() {
    //沉浸式状态栏
    changeStatusBar(color:widget.color,statusStyle: widget.statusStyle);
  }
}
