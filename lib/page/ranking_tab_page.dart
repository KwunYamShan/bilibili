import 'package:flutter/material.dart';
import 'package:flutter_bilibili/core/hi_base_tab_state.dart';
import 'package:flutter_bilibili/http/api/ranking_api.dart';
import 'package:flutter_bilibili/model/ranking_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/widget/video_large_card.dart';

class RankingTabPage extends StatefulWidget {
  final String sort;

  const RankingTabPage({Key? key, required this.sort}) : super(key: key);

  @override
  _RankingTabPageState createState() => _RankingTabPageState();
}

class _RankingTabPageState
    extends HiBaseTabState<RankingMo, VideoModel, RankingTabPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("_RankingTabPageState initState :"+widget.sort.toString());
  }
  @override
  // TODO: implement contentChild
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
  Future<RankingMo> getData(int pageIndex) async {
    RankingMo result =
        await RankingApi.get(widget.sort, pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(result) {
    return result.list;
  }
}
