import 'package:flutter_bilibili/http/api/login_api.dart';
import 'package:flutter_bilibili/util/hi_constants.dart';

enum HttpMethod { GET, POST, DELETE }

//基础请求
abstract class BaseRequest {
  var pathParams;
  var useHttps = true;

  //服务器域名
  String authority() {
    return "api.devio.org";
  }

  HttpMethod httpMethod();

  String path();

  String url() {
    Uri uri;
    var pathStr = path();
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams";
      } else {
        pathStr = "${path()}/$pathParams";
      }
    }

    if(needLogin()){
      //给需要登陆的接口携带登陆令牌
      addHeader(LoginApi.BOARDING_PASS, LoginApi.getBoardingPass());
    }
    //http与https的切换
    if (useHttps) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    print('BaseRequest-url()-uri:${uri.toString()}');
    return uri.toString();
  }

  bool needLogin();

  Map<String, String> params = Map();

  //添加参数
  BaseRequest add(String k, dynamic v) {
    params[k] = v.toString();
    return this;
  }

  Map<String, Object> header = {
    HiConstants.authTokenK:HiConstants.authTokenV,
    HiConstants.courseFlagK:HiConstants.courseFlagV//不定期更新//https://coding.imooc.com/learn/questiondetail/225589.html
  };

  //添加header
  BaseRequest addHeader(String k, Object v) {
    header[k] = v;
    return this;
  }
}
