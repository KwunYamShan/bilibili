//统一网络层返回格式
import 'package:flutter_bilibili/http/request/base_request.dart';
import 'dart:convert';

abstract class HiNetAdapter {
  Future <HiNetReponse<T>> send<T>(BaseRequest request);
}

class HiNetReponse<T> {
  HiNetReponse({this.data,
    this.request,
    this.statusCode,
    this.statusMessage,
    this.extra});

  T? data;
  BaseRequest? request;
  int? statusCode;
  String? statusMessage;
  dynamic extra;

  @override
  String toString() {
    // TODO: implement toString
    if (data is Map) {
      return json.encode(data);
    }
    return data.toString();
  }
}
