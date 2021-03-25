//Dio适配器
import 'package:dio/dio.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

import '../request/base_request.dart';
import '../request/base_request.dart';
import '../request/base_request.dart';
import 'hi_error.dart';
import 'hi_net_adapter.dart';
import 'hi_net_adapter.dart';
import 'hi_net_adapter.dart';

class DioAdapter extends HiNetAdapter{
  @override
  Future<HiNetReponse<T>> send<T>(BaseRequest request) async{
    //option是可选配置参数
    var response,options =  Options(headers:request.header);
    var error;
    try{
      if(request.httpMethod() == HttpMethod.GET){
        response = await Dio().get(request.url(),options: options);
      }else if(request.httpMethod() == HttpMethod.POST){
        response = await Dio().post(request.url(),options: options);
      }else if (request.httpMethod() == HttpMethod.DELETE){
        response = await Dio().delete(request.url(),options: options);
      }
    }on DioError catch(e){
      error = e;
      response = e.response;
    }
    if(error !=null){
      //抛出异常
      throw HiNetError(response?.statusCode ?? -1, error.toString(),data: buildRes(response,request));
    }
    return buildRes(response, request);
  }

  //构建HiNetResponse
  HiNetReponse buildRes(Response response, BaseRequest request) {
    return HiNetReponse(
      data: response.data,
      request: request,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response
    );
  }

}