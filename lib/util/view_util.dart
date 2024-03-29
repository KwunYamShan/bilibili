import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bilibili/util/color_util.dart';
import 'package:flutter_bilibili/util/format_util.dart';
import 'package:flutter_bilibili/widget/navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:flutter_bilibili/page/profile_page.dart';
import 'package:flutter_bilibili/provider/theme_provider.dart';

///带缓存的image
Widget cachedImage(String url, {double? width, double? height}) {
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
void changeStatusBar({color:Colors.white,StatusStyle statusStyle: StatusStyle.DARK_CONTENT, BuildContext? context}){
  if (context != null) {
    //fix Tried to listen to a value exposed with provider, from outside of the widget tree.
    var themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    if (themeProvider.isDark()) {
      statusStyle = StatusStyle.LIGHT_CONTENT;
      color = HiColor.dark_bg;
    }
  }
  var page = HiNavigator.getInstance().getCurrent()?.page;
  //fix Android切换 profile页面状态栏变白问题
  if (page is ProfilePage) {
    color = Colors.transparent;
  } else if (page is VideoDetailPage) {
    color = Colors.black;
    statusStyle = StatusStyle.LIGHT_CONTENT;
  }
  //沉浸式状态栏样式
  var brightness;
  if (Platform.isIOS) {
    brightness = statusStyle == StatusStyle.LIGHT_CONTENT
        ? Brightness.dark
        : Brightness.light;
  } else {
    brightness = statusStyle == StatusStyle.LIGHT_CONTENT
        ? Brightness.light
        : Brightness.dark;
  }
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    statusBarBrightness: brightness,
    statusBarIconBrightness: brightness,
  ));
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

//分割线
borderLine(BuildContext context, {bottom:true ,top:false}){
  BorderSide borderSide = BorderSide(width: 0.5,color: Colors.grey[200]!);
  return Border(
    bottom: bottom?borderSide:BorderSide.none,
    top: top?borderSide:BorderSide.none,
  );

}
///间距
SizedBox hiSpace({double height :1, double width:1}){
  return SizedBox(height: height, width: width,);
}
///底部阴影
BoxDecoration bottomBoxShadow(){
  return BoxDecoration(color: Colors.white,boxShadow: [
    BoxShadow(
      color: Colors.grey[100]!,
      offset: Offset(0,5),///xy轴偏移量
      blurRadius: 5,///阴影模糊程度
      spreadRadius: 1,///阴影扩散程度
    )
  ]);
}