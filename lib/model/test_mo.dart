
//网页版json转darthttps://www.devio.org/io/tools/json-to-dart/
//可以改类名 不能改字段名
class TestMo {
  late String id;
  late String vid;
  late String title;
  late String tname;
  late String url;
  late String cover;
  late int pubdate;
  late String desc;
  late int view;
  late int duration;
  late Owner owner;
  late int reply;
  late int favorite;
  late int like;
  late int coin;
  late int share;
  late String createTime;
  late int size;

  TestMo(
      {required this.id,
       required  this.vid,
       required  this.title,
       required  this.tname,
       required  this.url,
       required  this.cover,
       required  this.pubdate,
       required  this.desc,
       required  this.view,
       required  this.duration,
       required  this.owner,
       required  this.reply,
       required  this.favorite,
       required  this.like,
       required  this.coin,
       required  this.share,
       required  this.createTime,
       required  this.size});

  TestMo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vid = json['vid'];
    title = json['title'];
    tname = json['tname'];
    url = json['url'];
    cover = json['cover'];
    pubdate = json['pubdate'];
    desc = json['desc'];
    view = json['view'];
    duration = json['duration'];
    owner = new Owner.fromJson(json['owner']);
    reply = json['reply'];
    favorite = json['favorite'];
    like = json['like'];
    coin = json['coin'];
    share = json['share'];
    createTime = json['createTime'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vid'] = this.vid;
    data['title'] = this.title;
    data['tname'] = this.tname;
    data['url'] = this.url;
    data['cover'] = this.cover;
    data['pubdate'] = this.pubdate;
    data['desc'] = this.desc;
    data['view'] = this.view;
    data['duration'] = this.duration;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    data['reply'] = this.reply;
    data['favorite'] = this.favorite;
    data['like'] = this.like;
    data['coin'] = this.coin;
    data['share'] = this.share;
    data['createTime'] = this.createTime;
    data['size'] = this.size;
    return data;
  }
}

class Owner {
 late String name;
 late String face;
 late int fans;

  Owner({required this.name, required this.face, required this.fans});

  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['face'] = this.face;
    data['fans'] = this.fans;
    return data;
  }
}
