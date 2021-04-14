import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/home_request.dart';
import 'package:flutter_bilibili/model/home_mo.dart';

class HomeApi{
  static get(String categoryName,{int pageSize = 1,int pageIndex = 1}) async{
      HomeRequest request = HomeRequest();
      request.pathParams = categoryName;//路径参数  
      request.add("pageSize", pageSize).add("pageIndex", pageIndex);//查询参数
      var result = await HiNet.getInstance().fire(request);
      print("get方法："+result.toString());
      return HomeMo.fromJson(result['data']);
  }
}