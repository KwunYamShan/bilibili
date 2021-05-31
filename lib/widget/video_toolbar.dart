import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/video_detail_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/util/color_util.dart';
import 'package:flutter_bilibili/util/format_util.dart';
import 'package:flutter_bilibili/util/view_util.dart';

///视频点赞分享收藏工具栏
class VideoToolbar extends StatelessWidget {
  final VideoDetailMo detailMo; //bool isFavorite; bool isLike;
  final VideoModel videoModel; //数据
  final VoidCallback onLike;
  final VoidCallback onUnLike;
  final VoidCallback onFavorite;
  final VoidCallback onCoin;
  final VoidCallback onShare;

  const VideoToolbar({Key key,@required this.detailMo,@required this.videoModel, this.onLike, this.onUnLike, this.onFavorite, this.onCoin, this.onShare}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15,bottom: 10),
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          border: borderLine(context),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText(Icons.thumb_up_alt_rounded,videoModel.like,onClick: onLike,tint: detailMo?.isLike),
          _buildIconText(Icons.thumb_down_alt_rounded,"不喜欢",onClick: onUnLike),
          _buildIconText(Icons.monetization_on,videoModel.coin,onClick: onCoin),
          _buildIconText(Icons.grade_rounded,videoModel.favorite,onClick: onFavorite,tint: detailMo?.isFavorite),
          _buildIconText(Icons.share_rounded,videoModel.share,onClick: onShare),
      ],),
    );
  }

  //tint是否着色 true显示主题色
  _buildIconText(IconData iconData,text,{onClick,bool tint = false}){
      if(text is int){
        text = countFormat(text);
      }else if(text == null){
        text = "";
      }
      tint = tint == null? false :tint;
      return InkWell(
        onTap: onClick,
        child: Column(
          children: [
            Icon(iconData,color: tint?primary:Colors.grey,size: 20,),
            hiSpace(height: 5),
            Text(text,style: TextStyle(color: Colors.grey,fontSize: 12),),
          ],
        ),
      );
  }
}
