import 'package:flutter_bilibili/model/video_model.dart';

class FavoriteMo {
  /// total : 4
  /// list : [{"id":"5160","vid":"BV11s411k7ct","title":"【Re:0支线】剑鬼x剑圣的恋花物语——曾经想征服全世界,到最后回首才发现,这世界滴滴点点全部都是你","tname":"MAD·AMV","url":"https://o.devio.org/files/video/v=0R8IbpKXavM.mp4","cover":"https://o.devio.org/images/fa/swan-5936863__340.webp","pubdate":1472211352,"desc":"看完Re0第21集后，被剑鬼老爷和前代剑圣的故事感动到了，抽了一天时间为这对CP剪了个简单的小视频， 第一次日烧MAD虽然各种粗糙....但还是期待大家能感受到我的爱~\n\n泛式的微博  http://weibo.com/FunShiki","view":935018,"duration":293,"owner":{"name":"等待独白的戏","face":"https://o.devio.org/images/o_as/avatar/tx18.jpeg","fans":1807472197},"reply":3894,"favorite":53073,"like":18174,"coin":67527,"share":14181,"createTime":"2021-05-31 14:33:31","size":22917}]

  int total;
  List<VideoModel> list;

  FavoriteMo({this.total, this.list});

  FavoriteMo.fromJson(dynamic json) {
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
