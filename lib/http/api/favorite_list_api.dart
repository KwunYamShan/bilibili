import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/favorite_cancel_request.dart';
import 'package:flutter_bilibili/http/request/favorite_list_request.dart';
import 'package:flutter_bilibili/http/request/favorite_request.dart';
import 'package:flutter_bilibili/model/favorite_mo.dart';

class FavoriteListApi{
  static favorite({int pageIndex = 1, int pageSize = 10})async{
    BaseRequest request = FavoriteListRequest() ;
    request.add("pageIndex", pageIndex)
    .add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return FavoriteMo.fromJson(result["data"]);
  }
}