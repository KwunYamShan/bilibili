import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/ranking_request.dart';
import 'package:flutter_bilibili/model/ranking_mo.dart';

class RankingApi{
  static get(String sort,{int pageIndex = 1,int pageSize = 10}) async{
    RankingRequest request = RankingRequest();
    request.add("sort", sort)
    .add("pageSize", pageSize)
    .add("pageIndex", pageIndex);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return RankingMo.fromJson(result["data"]);
  }
}