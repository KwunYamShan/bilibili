import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_base_tab_state.dart';
import 'package:flutter_bilibili/http/api/favorite_list_api.dart';
import 'package:flutter_bilibili/model/favorite_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:flutter_bilibili/widget/video_large_card.dart';
///收藏
class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends HiBaseTabState<FavoriteMo,VideoModel,FavoritePage> {

  late RouteChangeListener listener;
  @override
  void initState() {
    super.initState();
    //从详情页返回刷新页面
    HiNavigator.getInstance().addListener(listener = (current, pre) => {
      if(pre.page is VideoDetailPage && current.page is FavoritePage){
        loadData()
      }
    });
  }
  @override
  void dispose() {
    HiNavigator.getInstance().removeListener(listener);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildNavigationBar(),Expanded(child: super.build(context))
      ],
    );
  }
  @override
  get contentChild => Container(
    child: ListView.builder(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 10),
      itemCount: dataList.length,
      controller: scrollController,
      itemBuilder: (BuildContext context, int index) =>
          VideoLargeCard(videoModel: dataList[index]),
    ),
  );

  @override
  Future<FavoriteMo> getData(int pageIndex) async{
    FavoriteMo request = await FavoriteListApi.favorite(pageSize: 10,pageIndex: pageIndex );
    return request;
  }

  @override
  List<VideoModel> parseList(FavoriteMo result) {
   return result.list;
  }
}

_buildNavigationBar() {
  return NavigationBar(
    child: Container(
      decoration: bottomBoxShadow(),
      alignment: Alignment.center,
      child: Text('收藏',style: TextStyle(fontSize: 16),),
    ),
  );
}
