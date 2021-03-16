import 'dart:convert';
import 'package:flutter_module/data/models/KoboUserResource.dart';
import 'package:http/http.dart' as http;

import '../http_service.dart';
import '../response_error.dart';
import '../api_request.dart';

class GetUserResources implements ApiRequest<KoboUserResourceResponse> {
  @override
  Future<Map> toMap() async {
    Map response = {};
    return response;
  }

  @override
  Future<KoboUserResourceResponse> fetch() async {
    http.Response myResponse = await HttpService.get(
      command: "/koboUser/userResources",
    );
    if (myResponse.statusCode == 200) {
      return KoboUserResourceResponse.fromJson(jsonDecode(myResponse.body));
    } else {
      throw await ResponseError.processError(response: myResponse);
    }
  }
}

class KoboUserResourceResponse extends KoboUserResource {
  KoboUserResourceResponse.fromJson(Map json) : super.fromJson(json);
}
