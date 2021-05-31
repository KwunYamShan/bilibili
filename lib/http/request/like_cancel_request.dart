import 'package:flutter_bilibili/http/request/base_request.dart';

import 'like_request.dart';

class LikeCancelRequest extends LikeRequest{
  @override
  HttpMethod httpMethod() {
    return HttpMethod.DELETE;
  }

}