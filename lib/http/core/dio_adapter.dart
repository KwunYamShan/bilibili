//Dio适配器
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bilibili/global/AppConstant.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

import '../request/base_request.dart';
import 'hi_error.dart';
import 'hi_net_adapter.dart';

class DioAdapter extends HiNetAdapter{
  @override
  Future<HiNetReponse<T>> send<T>(BaseRequest request) async{
    //option是可选配置参数
    var response,options =  Options(headers:request.header);
    var error;
    try{
      var dio = Dio();
      _proxy(dio);
      if(request.httpMethod() == HttpMethod.GET){
        response = await dio.get(request.url(),options: options);
      }else if(request.httpMethod() == HttpMethod.POST){
        response = await dio.post(request.url(),options: options);
      }else if (request.httpMethod() == HttpMethod.DELETE){
        response = await dio.delete(request.url(),options: options);
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

  ///设置代理
  void _proxy(Dio dio) {
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (client){

      //HandshakeException: Handshake error in client (OS Error:
      // CERTIFICATE_VERIFY_FAILED: unable to get local issuer certificate(handshake.cc:354)) 无法获取本地证书
      //  加入代码 强行信任
      //
      client.badCertificateCallback=(cert, host, port){
        return true;
      };

      // 设置代理用来调试应用
      client.findProxy = (Uri) {
        // 用1个开关设置是否开启代理
        return AppConstant.isDebug ? 'PROXY ${AppConstant.CHARLES_PROXY_IP}:${AppConstant.CHARLES_PROXY_PORT}' : 'DIRECT';
      };
    };
  }

}