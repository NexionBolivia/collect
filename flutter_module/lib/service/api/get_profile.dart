import 'dart:convert';
import 'package:flutter_module/data/models/profile.dart';
import 'package:http/http.dart' as http;

import '../http_service.dart';
import '../response_error.dart';
import '../api_request.dart';

class GetProfile implements ApiRequest<GetProfileResponse> {
  final String profileId;

  GetProfile(this.profileId);
  @override
  Future<Map> toMap() async {
    Map response = {"profileId": profileId};
    return response;
  }

  @override
  Future<GetProfileResponse> fetch() async {
    http.Response myResponse = await HttpService.get(
      command: "/Profile/Get",
      params: {"profileId": profileId},
    );
    if (myResponse.statusCode == 200) {
      return GetProfileResponse.fromJson(jsonDecode(myResponse.body));
    } else {
      throw await ResponseError.processError(response: myResponse);
    }
  }
}

class GetProfileResponse extends Profile {
  GetProfileResponse.fromJson(Map json) : super.fromJson(json);
}
