import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'package:flutter_bilibili/http/request/login_request.dart';
import 'package:flutter_bilibili/http/request/registration_request.dart';

class LoginApi {
  //登陆
  static login(String username, String password) {
    return _send(username, password);
  }

  //注册
  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  //发送请求
  static _send(String userName, String password, {imoocId, orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest();
    } else {
      request = LoginRequest();
    }
    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId)
        .add("orderId", orderId);
    var fire = await HiNet.getInstance().fire(request);
    print("LoginApi: send():"+fire.toString());
    if(fire['code'] == 0  && fire['data'] != null ){
      //保存登陆令牌
      HiCache.getInstance().setString(BOARDING_PASS, fire['data']);
    }
    return fire;
  }
  static getBoardingPass(){
    return HiCache.getInstance().get(BOARDING_PASS);
  }
  static String BOARDING_PASS = 'boarding-pass';
}
