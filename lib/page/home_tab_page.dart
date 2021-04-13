import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_mo.dart';

class HomeTabPage extends StatefulWidget {
  final String title;
  final List<BannerMo> bannerList;
  const HomeTabPage({Key key, this.title, this.bannerList}) : super(key: key);
  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.title),
    );
  }
}
