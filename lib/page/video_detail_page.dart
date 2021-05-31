import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bilibili/http/api/favorite_api.dart';
import 'package:flutter_bilibili/http/api/like_api.dart';
import 'package:flutter_bilibili/http/api/video_detail_api.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/model/Owner.dart';
import 'package:flutter_bilibili/model/video_detail_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/util/toast_util.dart';
import 'package:flutter_bilibili/util/view_util.dart';
import 'package:flutter_bilibili/widget/appbar.dart';
import 'package:flutter_bilibili/widget/expandable_content.dart';
import 'package:flutter_bilibili/widget/hi_tab.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:flutter_bilibili/widget/video_header.dart';
import 'package:flutter_bilibili/widget/video_large_card.dart';
import 'package:flutter_bilibili/widget/video_toolbar.dart';
import 'package:flutter_bilibili/widget/video_view.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage({Key  key, this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  TabController _controller;
  List tabs = ["简介", "评论288"];
  VideoDetailMo videoDetailMo;
  VideoModel videoModel; //更新数据
  List<VideoModel> videoList = [];

  @override
  void initState() {
    super.initState();
    //黑色状态栏，仅android
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);

    _controller = TabController(length: tabs.length, vsync: this);
    videoModel = widget.videoModel;
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
        child: videoModel.url !=null?Container(
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
        ):Container(),
      ),
    );
  }

  _buildVideoView() {
    var model = videoModel;
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
        ...buildVideoList(),
      ],
    );
  }

  buildContents() {
    return [
      VideoHeader(
        owner: videoModel.owner,
      ),
      ExpandableContent(mo: videoModel),
      VideoToolbar(detailMo: videoDetailMo,
        videoModel: videoModel,
        onLike: _doLike,
        onUnLike: _onUnLike,
      onFavorite: _onFavorite,) //传递的是方法的引用，而不是调用方法 所以不需要方法名加()   _doLike()
    ];
  }

  void _loadDetail() async {
    try {
      VideoDetailMo result = await VideoDetailDao.get(videoModel.vid);
      print(result);
      setState(() {
        videoDetailMo = result;
        videoModel = result.videoModel;//更新model
        videoList = result.videoList;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  void _doLike() async{
    try{
      var result = await LikeApi.like(videoModel.vid, !videoDetailMo.isLike);
      print(result);
      videoDetailMo.isLike = !videoDetailMo.isLike;
      if(videoDetailMo.isLike){
        videoModel.like+=1;
      }else{
        videoModel.like -=1;
      }
      setState(() {
        videoModel = videoModel;
        videoDetailMo = videoDetailMo;
      });
      showToast(result['msg']);
    }on NeedAuth catch(e){
      print(e);
      showWarnToast(e.message);
    }on HiNetError catch(e){
      print(e);
    }
  }

  void _onUnLike() {}

  ///收藏
  void _onFavorite() async {
    try{
      var result = await FavoriteApi.favorite(videoModel.vid, !videoDetailMo.isFavorite);
      print(result);
      videoDetailMo.isFavorite = !videoDetailMo.isFavorite;
      if(videoDetailMo.isFavorite){
        videoModel.favorite +=1;
      }else{
        videoModel.favorite -=1;
      }
      setState(() {
        videoModel = videoModel;
        videoDetailMo = videoDetailMo;
      });
      showToast(result['msg']);
    }on NeedAuth catch(e){
      print(e);
      showWarnToast(e.message);
    }on HiNetError catch(e){
      print(e);
    }
  }

  buildVideoList() {
    return videoList.map((mo) => VideoLargeCard(videoModel: mo)).toList();
  }
}
