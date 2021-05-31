import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/vide_detail_request.dart';
import 'package:flutter_bilibili/model/video_detail_mo.dart';

class VideoDetailDao{
  static get(String vid)async{
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams= vid;//在路径上的参数
    var result = await HiNet.getInstance().fire(request);//发送网络请求
    print(result);
    return VideoDetailMo.fromJson(result['data']);
  }
}