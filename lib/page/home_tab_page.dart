import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/api/home_api.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/home_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/util/toast_util.dart';
import 'package:flutter_bilibili/widget/hi_banner.dart';
import 'package:flutter_bilibili/widget/video_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerMo> bannerList;

  const HomeTabPage({Key key, this.categoryName, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

//AutomaticKeepAliveClientMixin让列表常驻内存
class _HomeTabPageState extends State<HomeTabPage> with AutomaticKeepAliveClientMixin{
  List<VideoModel> videoList = [];
  int pageIndex = 1;

  bool _loading = false;
  ScrollController _scrollController = ScrollController();//监听列表的滚动 上拉加载更多
  @override
  void initState() {
    super.initState();
     _initData();

    _scrollController.addListener(() {
      var dis = _scrollController.position.maxScrollExtent - _scrollController.position.pixels;//可滚动的最大距离- 当前已滚动距离

      print('dis:$dis');

      if(dis<100 && !_loading){//底部距离不足100时加载更多
        print('_loading:$_loading');
        _initData(loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(child:  MediaQuery.removePadding(
        context: context,
        removeTop: true,
        //crossAxisCount 列
        child: StaggeredGridView.countBuilder(
          controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),// 解决条目不能充满整个屏幕就无法下拉刷新的问题
            crossAxisCount: 2,
            itemCount: videoList.length,
            padding: EdgeInsets.all(10),
            itemBuilder: (BuildContext context, int index) {
              if (widget.bannerList != null && index == 0) {
                return _banner();
              } else {
                return VideoCard(
                  videoMo: videoList[index],
                );
              }
            },
            staggeredTileBuilder: (int index) {
              if (widget.bannerList != null && index == 0) {
                return StaggeredTile.fit(2); // 设置2 意思是独占1行  与crossAxisCount对应
              } else {
                return StaggeredTile.fit(1);
              }
            })), onRefresh: _initData)
      
     ;
  }

  _banner() {
    return HiBanner(widget.bannerList);

  }

  Future<void> _initData({loadMore = false}) async {
    _loading = true;
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      HomeMo result = await HomeApi.get(widget.categoryName,
          pageIndex: currentIndex, pageSize: 10);
      print('loadDataqqq:${result}');
      setState(() {
        _loading = false;
        if (loadMore) {
          if (result.videoList.isNotEmpty) {
            videoList = [...videoList, ...result.videoList];
            pageIndex++;
          }
        } else {
          videoList = result.videoList;
        }
      });

      // Future.delayed(Duration(milliseconds: 1000),(){//延时1秒
      //   _loading = false;
      // });
    } on NeedAuth catch (e) {
      _loading = false;
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      _loading = false;
      print(e);
      showWarnToast(e.message);
    }
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
