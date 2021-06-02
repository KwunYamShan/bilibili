import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/favorite_request.dart';

//收藏按钮
class FavoriteCancelRequest extends FavoriteRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.DELETE;
  }

}