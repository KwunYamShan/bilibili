import 'package:flutter/material.dart';
import 'package:flutter_bilibili/model/home_mo.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList;
  final double bannerHeight; //banner高度
  final EdgeInsetsGeometry padding; //

  const HiBanner(this.bannerList,
      {Key? key, this.bannerHeight = 160, required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      margin: EdgeInsets.only(bottom: 10),
      child: _banner(),
    );
  }

  _banner() {
    var right = 10 + (padding.horizontal ) / 2;
    return Swiper(
      itemCount: bannerList.length,
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return _image(bannerList[index]);
      },
      //自定义指示器
      pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              color: Colors.white60, size: 6, activeSize: 6,activeColor: Colors.white)),
    );
  }

  _image(BannerMo mo) {
    return InkWell(
      onTap: () {
        print(mo.title);
        _handleClick(mo);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: Image.network(
            mo.cover,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _handleClick(BannerMo mo) {
    if(mo.type == 'video'){
      HiNavigator.getInstance().onJumpTo(RouteStatus.detail,args: {'videoMo':VideoModel(vid: mo.url)});
    }else{
      _launchURL(mo.url);
    }

    print("_handleClick:${mo.type} , ${mo.url}");

  }
  void _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
