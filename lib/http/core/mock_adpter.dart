import 'package:flutter_bilibili/http/core/hi_net_adapter.dart';
import 'package:flutter_bilibili/http/request/base_request.dart';

class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetReponse<T>> send<T>(BaseRequest request) {
    return Future.delayed(Duration(milliseconds: 1000), () {
      return HiNetReponse(
        request: request,
          data: {"code": 0, "message": "success"} as T, statusCode: 200);
    });
  }
}
