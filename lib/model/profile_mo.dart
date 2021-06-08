/// code : 0
/// data : {"name":"wuhao","face":"https://o.devio.org/images/other/fa_avatar.png","fans":66,"favorite":4,"like":1,"coin":888,"browsing":30,"bannerList":[{"id":"2","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"Flutter从入门到进阶-实战携程网App","url":"https://coding.imooc.com/class/321.html","cover":"https://o.devio.org/images/o_as/other/flutter_321.jpg","createTime":"2020-06-11 23:48:38"},{"id":"8","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"带你解锁React Native开发应用新姿势，一网打尽React Native新版本热门技术","url":"https://coding.imooc.com/class/304.html","cover":"https://o.devio.org/images/other/rn-cover2.png","createTime":"2020-11-04 13:54:06"},{"id":"9","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"移动端普通工程师到架构师的全方位蜕变","url":"http://class.imooc.com/sale/mobilearchitect","cover":"https://o.devio.org/images/other/as-cover.png","createTime":"2021-06-01 11:17:43"},{"id":"10","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"Flutter高级进阶实战 仿哔哩哔哩APP","url":"https://coding.imooc.com/class/487.html","cover":"https://img4.mukewang.com/604ec1a30001d21b17920764.jpg","createTime":"2021-03-15 11:51:12"}],"courseList":[{"name":"移动端架构师","cover":"https://o.devio.org/images/fa/banner/mobilearchitect.png","url":"https://class.imooc.com/sale/mobilearchitect","group":1},{"name":"Flutter从基础到进阶","cover":"https://o.devio.org/images/fa/banner/flutter.png","url":"https://coding.imooc.com/class/321.html","group":1},{"name":"React Native从入门到实战打造高质量上线App","cover":"https://o.devio.org/images/fa/banner/rn.png","url":"https://coding.imooc.com/class/304.html","group":2},{"name":"Flutter 实战哔哩哔哩","cover":"https://o.devio.org/images/fa/banner/fa.png","url":"https://coding.imooc.com/class/487.html","group":2}],"benefitList":[{"name":"交流群","url":"660782755"},{"name":"问答区","url":"https://coding.imooc.com/class/487.html"},{"name":"电子书","url":"https://www.imooc.com/t/4951150#Article"}]}
/// msg : "SUCCESS."

class ProfileMo {
  int code;
  Data data;
  String msg;

  ProfileMo({
      this.code, 
      this.data, 
      this.msg});

  ProfileMo.fromJson(dynamic json) {
    code = json["code"];
    data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    msg = json["msg"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["code"] = code;
    if (data != null) {
      map["data"] = data.toJson();
    }
    map["msg"] = msg;
    return map;
  }

}

/// name : "wuhao"
/// face : "https://o.devio.org/images/other/fa_avatar.png"
/// fans : 66
/// favorite : 4
/// like : 1
/// coin : 888
/// browsing : 30
/// bannerList : [{"id":"2","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"Flutter从入门到进阶-实战携程网App","url":"https://coding.imooc.com/class/321.html","cover":"https://o.devio.org/images/o_as/other/flutter_321.jpg","createTime":"2020-06-11 23:48:38"},{"id":"8","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"带你解锁React Native开发应用新姿势，一网打尽React Native新版本热门技术","url":"https://coding.imooc.com/class/304.html","cover":"https://o.devio.org/images/other/rn-cover2.png","createTime":"2020-11-04 13:54:06"},{"id":"9","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"移动端普通工程师到架构师的全方位蜕变","url":"http://class.imooc.com/sale/mobilearchitect","cover":"https://o.devio.org/images/other/as-cover.png","createTime":"2021-06-01 11:17:43"},{"id":"10","sticky":1,"type":"recommend","title":"好课推荐","subtitle":"Flutter高级进阶实战 仿哔哩哔哩APP","url":"https://coding.imooc.com/class/487.html","cover":"https://img4.mukewang.com/604ec1a30001d21b17920764.jpg","createTime":"2021-03-15 11:51:12"}]
/// courseList : [{"name":"移动端架构师","cover":"https://o.devio.org/images/fa/banner/mobilearchitect.png","url":"https://class.imooc.com/sale/mobilearchitect","group":1},{"name":"Flutter从基础到进阶","cover":"https://o.devio.org/images/fa/banner/flutter.png","url":"https://coding.imooc.com/class/321.html","group":1},{"name":"React Native从入门到实战打造高质量上线App","cover":"https://o.devio.org/images/fa/banner/rn.png","url":"https://coding.imooc.com/class/304.html","group":2},{"name":"Flutter 实战哔哩哔哩","cover":"https://o.devio.org/images/fa/banner/fa.png","url":"https://coding.imooc.com/class/487.html","group":2}]
/// benefitList : [{"name":"交流群","url":"660782755"},{"name":"问答区","url":"https://coding.imooc.com/class/487.html"},{"name":"电子书","url":"https://www.imooc.com/t/4951150#Article"}]

class Data {
  String name;
  String face;
  int fans;
  int favorite;
  int like;
  int coin;
  int browsing;
  List<BannerList> bannerList;
  List<CourseList> courseList;
  List<BenefitList> benefitList;

  Data({
      this.name, 
      this.face, 
      this.fans, 
      this.favorite, 
      this.like, 
      this.coin, 
      this.browsing, 
      this.bannerList, 
      this.courseList, 
      this.benefitList});

  Data.fromJson(dynamic json) {
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
        bannerList.add(BannerList.fromJson(v));
      });
    }
    if (json["courseList"] != null) {
      courseList = [];
      json["courseList"].forEach((v) {
        courseList.add(CourseList.fromJson(v));
      });
    }
    if (json["benefitList"] != null) {
      benefitList = [];
      json["benefitList"].forEach((v) {
        benefitList.add(BenefitList.fromJson(v));
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

class BenefitList {
  String name;
  String url;

  BenefitList({
      this.name, 
      this.url});

  BenefitList.fromJson(dynamic json) {
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

class CourseList {
  String name;
  String cover;
  String url;
  int group;

  CourseList({
      this.name, 
      this.cover, 
      this.url, 
      this.group});

  CourseList.fromJson(dynamic json) {
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

/// id : "2"
/// sticky : 1
/// type : "recommend"
/// title : "好课推荐"
/// subtitle : "Flutter从入门到进阶-实战携程网App"
/// url : "https://coding.imooc.com/class/321.html"
/// cover : "https://o.devio.org/images/o_as/other/flutter_321.jpg"
/// createTime : "2020-06-11 23:48:38"

class BannerList {
  String id;
  int sticky;
  String type;
  String title;
  String subtitle;
  String url;
  String cover;
  String createTime;

  BannerList({
      this.id, 
      this.sticky, 
      this.type, 
      this.title, 
      this.subtitle, 
      this.url, 
      this.cover, 
      this.createTime});

  BannerList.fromJson(dynamic json) {
    id = json["id"];
    sticky = json["sticky"];
    type = json["type"];
    title = json["title"];
    subtitle = json["subtitle"];
    url = json["url"];
    cover = json["cover"];
    createTime = json["createTime"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = id;
    map["sticky"] = sticky;
    map["type"] = type;
    map["title"] = title;
    map["subtitle"] = subtitle;
    map["url"] = url;
    map["cover"] = cover;
    map["createTime"] = createTime;
    return map;
  }

}