import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_base_tab_state.dart';
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
class _HomeTabPageState
    extends HiBaseTabState<HomeMo, VideoModel, HomeTabPage> {
  @override
  void initState() {
    super.initState();
    print("_HomeTabPageState initState :"+widget.categoryName);
    print("_HomeTabPageState initState :"+widget.bannerList.toString());
  }

  _banner() {
    return HiBanner(widget.bannerList);
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  // TODO: implement contentChild
  get contentChild => StaggeredGridView.countBuilder(
      controller: scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      // 解决条目不能充满整个屏幕就无法下拉刷新的问题
      crossAxisCount: 2,
      itemCount: dataList.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (BuildContext context, int index) {
        if (widget.bannerList != null && index == 0) {
          return _banner();
        } else {
          return VideoCard(
            videoMo: dataList[index],
          );
        }
      },
      staggeredTileBuilder: (int index) {
        if (widget.bannerList != null && index == 0) {
          return StaggeredTile.fit(2); // 设置2 意思是独占1行  与crossAxisCount对应
        } else {
          return StaggeredTile.fit(1);
        }
      });

  @override
  Future<HomeMo> getData(int pageIndex) async {
    return await HomeApi.get(widget.categoryName,
        pageIndex: pageIndex, pageSize: 10);
  }

  @override
  List<VideoModel> parseList(HomeMo result) {
    return result.videoList;
  }
}
