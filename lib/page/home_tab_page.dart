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

class _HomeTabPageState extends State<HomeTabPage> {
  List<VideoModel> videoList = [];
  int pageIndex = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        //crossAxisCount 列
        child: StaggeredGridView.countBuilder(
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
            }));
  }

  _banner() {
    return HiBanner(widget.bannerList);

  }

  void _initData({loadMore = false}) async {
    if (!loadMore) {
      pageIndex = 1;
    }
    var currentIndex = pageIndex + (loadMore ? 1 : 0);
    try {
      HomeMo result = await HomeApi.get(widget.categoryName,
          pageIndex: currentIndex, pageSize: 10);
      print('loadData:${result}');
      setState(() {
        if (loadMore) {
          if (result.videoList.isNotEmpty) {
            videoList = [...videoList, ...result.videoList];
            pageIndex++;
          }
        } else {
          videoList = result.videoList;
        }
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }
}
