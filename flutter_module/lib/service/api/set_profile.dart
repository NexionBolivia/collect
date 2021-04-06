import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../http_service.dart';
import '../response_error.dart';
import '../api_request.dart';

class SetProfile implements ApiRequest<String> {
  SetProfile({
    @required this.id,
    @required this.formation,
    @required this.address,
    @required this.phone,
    @required this.professionals,
    @required this.employes,
    @required this.department,
    @required this.province,
    @required this.municipality,
    @required this.waterConnections,
    @required this.connectionsWithMeter,
    @required this.connectionsWithoutMeter,
    @required this.publicPools,
    @required this.latrines,
    @required this.serviceContinuity,
  });

  final String id;
  final String formation;
  final String address;
  final String phone;
  final int professionals;
  final int employes;
  final String department;
  final String province;
  final String municipality;
  final int waterConnections;
  final int connectionsWithMeter;
  final int connectionsWithoutMeter;
  final int publicPools;
  final int latrines;
  final String serviceContinuity;

  @override
  Future<Map> toMap() async {
    Map response = {
      "profileId": id,
      "formation": formation,
      "address": address,
      "phone": phone,
      "professionals": professionals,
      "employes": employes,
      "department": department,
      "province": province,
      "municipality": municipality,
      "waterConnections": waterConnections,
      "connectionsWithMeter": connectionsWithMeter,
      "connectionsWithoutMeter": connectionsWithoutMeter,
      "publicPools": publicPools,
      "latrines": latrines,
      "serviceContinuity": serviceContinuity,
    };
    return response;
  }

  @override
  Future<String> fetch() async {
    http.Response myResponse = await HttpService.post(
      command: "/Profile/Update",
      body: await toMap(),
    );
    if (myResponse.statusCode == 200) {
      return "ok";
    } else {
      throw await ResponseError.processError(response: myResponse);
    }
  }
}
