import 'package:flutter_bilibili/http/request/base_request.dart';

//收藏列表
class FavoriteListRequest extends BaseRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return 'uapi/fa/favorites';
  }

}