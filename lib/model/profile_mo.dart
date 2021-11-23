//个人中心模块
import 'package:flutter_bilibili/model/home_mo.dart';

class ProfileMo {

  late String name;
  late String face;
  late int fans;
  late int favorite;
  late int like;
  late int coin;
  late int browsing;
  late List<BannerMo> bannerList;
  late List<Course> courseList;
  late List<Benefit> benefitList;

  ProfileMo({
      required this.name,
      required this.face,
      required this.fans,
      required this.favorite,
      required this.like,
      required this.coin,
      required this.browsing,
      required this.bannerList,
      required this.courseList,
      required this.benefitList});

  ProfileMo.fromJson(dynamic json) {
    name = json["name"];
    face = json["face"];
    fans = json["fans"];
    favorite = json["favorite"];
    like = json["like"];
    coin = json["coin"];
    browsing = json["browsing"];
    if (json["bannerList"] != null) {
      bannerList = [];
      json["bannerList"].forEach((v) {
        bannerList.add(BannerMo.fromJson(v));
      });
    }
    if (json["courseList"] != null) {
      courseList = [];
      json["courseList"].forEach((v) {
        courseList.add(Course.fromJson(v));
      });
    }
    if (json["benefitList"] != null) {
      benefitList = [];
      json["benefitList"].forEach((v) {
        benefitList.add(Benefit.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["face"] = face;
    map["fans"] = fans;
    map["favorite"] = favorite;
    map["like"] = like;
    map["coin"] = coin;
    map["browsing"] = browsing;
    if (bannerList != null) {
      map["bannerList"] = bannerList.map((v) => v.toJson()).toList();
    }
    if (courseList != null) {
      map["courseList"] = courseList.map((v) => v.toJson()).toList();
    }
    if (benefitList != null) {
      map["benefitList"] = benefitList.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "交流群"
/// url : "660782755"

class Benefit {
  late String name;
  late String url;

  Benefit({
      required this.name,
      required this.url});

  Benefit.fromJson(dynamic json) {
    name = json["name"];
    url = json["url"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["url"] = url;
    return map;
  }

}

/// name : "移动端架构师"
/// cover : "https://o.devio.org/images/fa/banner/mobilearchitect.png"
/// url : "https://class.imooc.com/sale/mobilearchitect"
/// group : 1

class Course {
  late String name;
  late String cover;
  late String url;
  late int group;

  Course({
      required this.name,
      required this.cover,
      required this.url,
      required this.group});

  Course.fromJson(dynamic json) {
    name = json["name"];
    cover = json["cover"];
    url = json["url"];
    group = json["group"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["name"] = name;
    map["cover"] = cover;
    map["url"] = url;
    map["group"] = group;
    return map;
  }

}
