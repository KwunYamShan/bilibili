import 'package:flutter/material.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';

///排行
class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> with TickerProviderStateMixin{
  TabController _controller ;
  @override
  void initState() {
    super.initState();
    _controller =
        TabController(length: TABS.length, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        child: Column(
          children: [
            NavigationBar(
              color: Colors.white,
              statusStyle: StatusStyle.DARK_CONTENT,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [_tabBar()],
              ),
            )
          ],
        ),
      ),
    );
  }

  static const TABS = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"},
  ];

  _tabBar() {
    return HiTab(TABS.map<Tab>((tab) => Tab(text: tab["name"],)).toList(),fontSize: 16,
        borderWidth: 3,
        unselectedLabelColor: Colors.black54,
        controller: _controller,);
  }
}
