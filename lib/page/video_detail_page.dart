import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/api/video_detail_api.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/Owner.dart';
import 'package:flutter_bilibili/model/v_ideo_detail_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/util/toast_util.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/expandable_content.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:flutter_bilibili/widget/video_header.dart';
import 'package:flutter_bilibili/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage({Key key, this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  TabController _controller;
  List tabs = ["简介", "评论288"];
  VIdeoDetailMo videoDetailMo;
  @override
  void initState() {
    super.initState();
    //黑色状态栏，仅android
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);

    _controller = TabController(length: tabs.length, vsync: this);
    _loadDetail();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        context: context,
        removeTop: Platform.isIOS,
        child: Container(
          child: Column(
            children: [
              //ios下的黑色状态栏
              NavigationBar(
                color: Colors.black,
                statusStyle: StatusStyle.LIGHT_CONTENT,
                height: Platform.isAndroid ? 0 : 46,
              ),
              _buildVideoView(),
              _buildTabNavigation(),
              Flexible(
                  child: TabBarView(
                controller: _controller,
                children: [
                  _buildDetailList(),
                  Container(
                    child: Text("敬请期待"),
                  )
                ],
              )), //填充剩余空间
            ],
          ),
        ),
      ),
    );
  }

  _buildVideoView() {
    var model = widget.videoModel;
    return VideoView(
      model.url,
      cover: model.cover,
      overlayUI: videoAppbar(),
    );
  }

  //带阴影效果的导航
  _buildTabNavigation() {
    return Material(
      elevation: 5,
      shadowColor: Colors.grey[100],
      child: Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.live_tv_rounded,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((name) => Tab(text: name)).toList(),
      controller: _controller,
    );
  }

  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0),
      children: [
        ...buildContents(),
        Container(
          height: 500,
          margin: EdgeInsets.only(top: 10),
          alignment: Alignment.topLeft,
          decoration: BoxDecoration(color: Colors.lightBlueAccent),
          child: Text("展开列表"),
        )
      ],
    );
  }

  buildContents() {
    return [
      Container(
        child: VideoHeader(
          owner: widget.videoModel.owner,
        ),
      ),
      ExpandableContent(mo: widget.videoModel )
    ];
  }

  void _loadDetail() async{
    try{
      VIdeoDetailMo result = await VideoDetailDao.get(widget.videoModel.vid);
      print(result);
      setState(() {
        videoDetailMo = result;
      });
    }on NeedAuth catch(e){
      print(e);
      showWarnToast(e.message);
    }on HiNetError catch(e){
      print(e);

    }
  }
}
