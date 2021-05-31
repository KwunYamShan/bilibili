import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/format_util.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:flutter_statusbar_manager/flutter_statusbar_manager.dart';

///带缓存的image
Widget cachedImage(String url, {double width, double height}) {
  return CachedNetworkImage(
    imageUrl: url,
    width: width,
    fit: BoxFit.cover,
    height: height,
    placeholder: (
      BuildContext context,
      String url,
    ) =>
        Container(
      color: Colors.grey[200],
    ),
    errorWidget: (
      BuildContext context,
      String url,
      dynamic error,
    ) =>
        Icon(Icons.error),
  );
}

//黑色线性渐变
blackLinearGradient({bool fromTop = false}) {
  return LinearGradient(
      begin: fromTop ? Alignment.topCenter : Alignment.bottomCenter,
      end: fromTop ? Alignment.bottomCenter : Alignment.topCenter,
      colors: [
        Colors.black54,
        Colors.black45,
        Colors.black38,
        Colors.black26,
        Colors.black12,
        Colors.transparent,
      ]);
}
//修改状态栏
void changeStatusBar({color:Colors.black,StatusStyle statusStyle: StatusStyle.DARK_CONTENT}){
  //沉浸式状态栏样式
  FlutterStatusbarManager.setColor(color,animated: false);
  FlutterStatusbarManager.setStyle(statusStyle == StatusStyle.DARK_CONTENT?StatusBarStyle.DARK_CONTENT:StatusBarStyle.LIGHT_CONTENT);
}

///带文字的小图标
smallIconText(IconData iconData, var text){
  var style = TextStyle(fontSize: 12,color: Colors.grey);
  if(text is int){
    text = countFormat(text);
  }
  return [
    Icon(iconData,color: Colors.grey,size: 12,),
    Text('$text',style: style,)
  ];
}
