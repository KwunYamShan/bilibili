import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/favorite_cancel_request.dart';
import 'package:flutter_bilibili/http/request/favorite_request.dart';
import 'package:flutter_bilibili/http/request/like_cancel_request.dart';
import 'package:flutter_bilibili/http/request/like_request.dart';

class LikeApi{
  static like(String vid, bool favorite)async{
    BaseRequest request = favorite ? LikeRequest() :LikeCancelRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }
}