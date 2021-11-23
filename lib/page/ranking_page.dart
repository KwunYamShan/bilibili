import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/api/ranking_api.dart';
import 'package:flutter_bilibili/page/ranking_tab_page.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';

///排行
class RankingPage extends StatefulWidget {
  @override
  _RankingPageState createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage>
    with TickerProviderStateMixin {
  static const TABS = [
    {"key": "like", "name": "最热"},
    {"key": "pubdate", "name": "最新"},
    {"key": "favorite", "name": "收藏"},
  ];

  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: TABS.length, vsync: this);
    //RankingApi.get("like");
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            _buildNavigationBar(),
            _buildTabView(),
          ],
        ),
      ),
    );
  }

  _buildNavigationBar() {
    return NavigationBar(
      child: Container(
        alignment: Alignment.center,
        child: _tabBar(),
        decoration: bottomBoxShadow(),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      TABS
          .map<Tab>((tab) => Tab(
                text: tab["name"],
              ))
          .toList(),
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      controller: _controller,
    );
  }

  _buildTabView() {
    return Flexible(
        //Flexible撑开底部剩余空间
        child: TabBarView(
            controller: _controller,
            children: TABS.map((tab) {
              return RankingTabPage(sort: tab['key']??"null fuck");
            }).toList()));
  }
}
