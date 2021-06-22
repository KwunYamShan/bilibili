
import 'package:flutter/cupertino.dart';
import 'package:flutter_bilibili/http/api/login_api.dart';
import 'package:flutter_bilibili/model/barrage_mo.dart';
import 'package:flutter_bilibili/util/hi_constants.dart';
import 'package:web_socket_channel/io.dart';
//负责与后端进行websocket通信
class HiSocket implements ISocket {
  static const _URL = 'wss://api.devio.org/uapi/fa/barrage/';
  IOWebSocketChannel _channel;
  ValueChanged<List<BarrageModel>> _callBack;

  //心跳间隔秒数，根据服务器实际timeout时间来调整，这里Mginx服务器的timeout为60秒,Mginx超时后会关闭连接 所以websocket超时时间小于Mginx即可 但不建议设置太小会增加服务器的压力
  int _intervalSeconds = 50;

  @override
  void close() {
    if(_channel !=null){
      _channel.sink.close();
    }
  }

  @override
  ISocket listen(callBack) {
    _callBack = callBack;
    return this;
  }

  @override
  ISocket open(String vid) {
    //建立socket连接
    _channel = IOWebSocketChannel.connect(_URL + vid, headers: _headers(),pingInterval: Duration(seconds: _intervalSeconds));
    _channel.stream.handleError((Object error) {
      print('连接发生错误：$error');
    }).listen((message) {
      _handleMessage(message);//处理服务端返回的信息
    });
    return this;
  }

  @override
  ISocket send(String message) {
    _channel.sink.add(message);
    return this;
  }


  _headers() {
    //设置请求头校验，注意留意：Console的log输出：flutter：received返回错误信息
    Map<String ,dynamic> header = {
      HiConstants.authTokenK:HiConstants.authTokenV,
      HiConstants.courseFlagK:HiConstants.courseFlagV
    };
    header[LoginApi.BOARDING_PASS] = LoginApi.getBoardingPass();
    return header;
  }

  void _handleMessage(message) {
    print('HiSocket:_handleMessage received:$message');
    var result = BarrageModel.fromJsonString(message);

    if(result!=null && _callBack!=null){
      _callBack(result);
    }
  }
}


abstract class ISocket {
  //和服务端建立链接
  ISocket open(String vid);

  //发送弹幕
  ISocket send(String message);

  //关闭连接
  void close();

  //接收弹幕
  ISocket listen(ValueChanged<List<BarrageModel>> callBack);
}
