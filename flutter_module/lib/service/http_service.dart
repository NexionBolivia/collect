import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

// https://192.168.100.3:63253
class HttpService {
  static MethodChannel _platform = const MethodChannel('FLUTTER_MODULE');
  static Duration delay = Duration();
  static final Uri _serverUrl = Uri(
    host: "192.168.100.3",
    scheme: "http",
    port: 63253,
  );

  static String get serverUrl => _serverUrl.toString();

  static Future<String> _token() async {
    String response = await _platform
        .invokeMethod<String>("GET_TOKEN")
        .catchError((error) => null);
    return response;
    // return response ??
    //     "eyJhbGciOiJIUzUxMiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiJlc2N1ZWxhMSIsImh0dHA6Ly9zY2hlbWFzLm1pY3Jvc29mdC5jb20vd3MvMjAwOC8wNi9pZGVudGl0eS9jbGFpbXMvdXNlcmRhdGEiOiI4NzdkNjA1ZjFlOGY3OGY3NjIzNGEyNWRiNDUyOTA3ZWUwMWRhOGU4IiwibmJmIjoxNjE1OTIxNDgyLCJleHAiOjE2MTg1MTM0ODIsImlhdCI6MTYxNTkyMTQ4Mn0.ammg6QvBupZmGgzexjnGMB_J1b9kSy1Rta7QRZ1j3sXMwuuSR_b6-UiiBFwwiBR05mgXirs-M49kDinr2c_40A";
  }

  static Future<http.Response> post({
    String command = "/",
    dynamic body,
  }) async {
    if (body == null) body = {};
    body.removeWhere((key, value) => value == null);
    Uri uir = Uri(
      host: _serverUrl.host,
      port: _serverUrl.port,
      scheme: _serverUrl.scheme,
      path: _serverUrl.path + command,
    );
    String bodyString = jsonEncode(body);
    log(uir.toString());
    log("Service POST => $command body => $bodyString");
    return http
        .post(
      uir,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${await _token()}",
      },
      body: bodyString,
    )
        .then((value) {
      log("Service POST <= $command body => ${value?.body ?? 'no body'}");
      return Future.delayed(delay).then((_) => value);
    });
  }

  static Future<http.Response> get({
    String command = "/",
    Map<String, dynamic> params,
  }) async {
    if (params == null) params = {};
    params.removeWhere((key, value) => value == null);
    Uri uir = Uri(
      queryParameters: params,
      port: _serverUrl.port,
      host: _serverUrl.host,
      scheme: _serverUrl.scheme,
      path: _serverUrl.path + command,
    );
    log(uir.toString());
    log("Service GET => $command body => ${jsonEncode(params)}");
    return http.get(uir, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${await _token()}",
    }).then((value) {
      log("Service GET <= $command? body => ${value?.body ?? 'no body'}");
      return Future.delayed(delay).then((_) => value);
    });
  }
}
