import 'package:flutter/material.dart';
import 'package:flutter_bilibili/page/favorite_page.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/profile_page.dart';
import 'package:flutter_bilibili/page/ranking_page.dart';
import 'package:flutter_bilibili/util/color_util.dart';

class BottomNavigator extends StatefulWidget {
  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey;
  final _activeColor = primary;
  int _currentIndex = 0;
  final PageController _controller = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        children: [
          HomePage(),
          RankingPage(),
          FavoritePage(),
          ProfilePage(),
        ],
        onPageChanged: (index) {
          //联动
          setState(() {
            //控制选中第一个tab
            _currentIndex = index;
          });
        },
        physics: NeverScrollableScrollPhysics(), //禁止横向滚动
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          //让pageview展示对应的tab
          _controller.jumpToPage(index);
          setState(() {
            //控制选中第一个tab
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: _activeColor,
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('排行', Icons.local_fire_department, 1),
          _bottomItem('收藏', Icons.favorite, 2),
          _bottomItem('我的', Icons.live_tv, 3),
        ],
      ),
    );
  }

  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
    );
  }
}
