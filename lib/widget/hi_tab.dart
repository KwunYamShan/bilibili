import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/color_util.dart';
import 'package:underline_indicator/underline_indicator.dart';

//顶部tab切换组件
class HiTab extends StatefulWidget {
  final List<Widget> tabs;
  final TabController? controller;
  final double fontSize;
  final double borderWidth;
  final double insets;
  final Color unselectedLabelColor;

  const HiTab(this.tabs,
      {Key? key,
      this.controller,
      this.fontSize = 13,
      this.borderWidth = 2,
      this.insets= 15,
      this.unselectedLabelColor=  Colors.grey})
      : super(key: key);

  @override
  _HiTabState createState() => _HiTabState();
}

class _HiTabState extends State<HiTab> {
  @override
  Widget build(BuildContext context) {
    return TabBar(
        controller: widget.controller,
        isScrollable: true,
        //控制tabbar是否可以横向滚动
        labelColor: primary,
        unselectedLabelColor: widget.unselectedLabelColor,
        labelStyle: TextStyle(fontSize: widget.fontSize),
        indicator: UnderlineIndicator(
          strokeCap: StrokeCap.round, //圆角
          borderSide: BorderSide(color: primary, width: widget.borderWidth),
          insets: EdgeInsets.only(left: widget.insets, right: widget.insets), //内边距
        ),
        tabs: widget.tabs);
  }
}
