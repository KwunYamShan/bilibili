import 'package:flutter_bilibili/model/video_model.dart';

/// code : 0
/// data : {"total":933,"list":[{"id":"203","vid":"BV1qt411j7fV","title":"【派大星的独白】一个关于正常人的故事","tname":"鬼畜调教","url":"https://o.devio.org/files/video/v=mllXxyHTzfg.mp4","cover":"https://o.devio.org/images/fa/photo-1612485222394-376d81a3e829.webp","pubdate":1564199758,"desc":"BGM: Flower dance--Dj Okawari\n以此视频为自己最喜欢的一个视频作纪念。\n视频素材出处为《海绵宝宝》，是一部由舍曼·科恩、沃特·杜赫、山姆·亨德森、保罗·蒂比特等导的美国喜剧动画。\n本视频音频部分节选自央配版海绵宝宝，其主要配音演员为陈浩，李易，孙悦斌，白涛等。\n黄绿合战Day.9 对阵作品：av60738739 投票传送门：https://www.bilibili.com/blackboard/activity-yellowVSgreen4th.html","view":48425057,"duration":339,"owner":{"name":"捏你face.","face":"https://o.devio.org/images/o_as/avatar/tx10.jpeg","fans":1583958789},"reply":49584,"favorite":2552200,"like":3410278,"coin":3603132,"share":729353,"createTime":"2020-11-14 19:35:54","size":23962}]}
/// msg : "SUCCESS."

class RankingMo {

  late int total;
  late List<VideoModel> list;

  RankingMo({
      required this.total,
      required this.list});

  RankingMo.fromJson(dynamic json) {
    total = json["total"];
    if (json["list"] != null) {
      list = [];
      json["list"].forEach((v) {
        list.add(VideoModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["total"] = total;
    if (list != null) {
      map["list"] = list.map((v) => v.toJson()).toList();
    }
    return map;
  }

}