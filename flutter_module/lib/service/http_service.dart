import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static MethodChannel _platform = const MethodChannel('FLUTTER_MODULE');
  static Duration delay = Duration();
  static final Uri _serverUrl = Uri(
    host: "support.nexion-dev.tk",
    scheme: "https",
    path: "/dummy/mobile",
  );

  static String get serverUrl => _serverUrl.toString();

  static Future<String> _token() async {
    String response = await _platform
        .invokeMethod<String>("GET_TOKEN")
        .catchError((error) => null);
    return response ?? "ddb11eb9-5ff8-4028-a8c3-ef20cbe576b8";
  }

  static Future<http.Response> post({
    String command = "/",
    dynamic body,
  }) async {
    if (body == null) body = {};
    body.removeWhere((key, value) => value == null);
    Uri uir = Uri(
      host: _serverUrl.host,
      // port: _serverUrl.port,
      scheme: _serverUrl.scheme,
      path: _serverUrl.path + command,
    );
    String bodyString = jsonEncode(body);
    log(uir.toString());
    log("Service POST => $command body => $bodyString");
    return http
        .post(
      uir,
      headers: {"Content-Type": "application/json", "token": await _token()},
      body: bodyString,
    )
        .then((value) {
      log("Service POST <= $command body => ${value?.body ?? 'no body'}");
      return Future.delayed(delay).then((_) => value);
    });
  }

  static Future<http.Response> put({
    String command = "/",
    dynamic body,
  }) async {
    if (body == null) body = {};
    body.removeWhere((key, value) => value == null);
    Uri uir = Uri(
      host: _serverUrl.host,
      // port: _serverUrl.port,
      scheme: _serverUrl.scheme,
      path: _serverUrl.path + command,
    );
    String bodyString = jsonEncode(body);
    log("Service PUT => $command body => $bodyString");
    return http
        .put(uir,
            headers: {
              "Content-Type": "application/json",
              "token": await _token()
            },
            body: bodyString)
        .then((value) {
      log("Service PUT <= $command body => ${value?.body ?? 'no body'}");
      return Future.delayed(delay).then((_) => value);
    });
  }

  static Future<http.Response> delete({
    String command = "/",
    Map<String, dynamic> params,
  }) async {
    if (params == null) params = {};
    params.removeWhere((key, value) => value == null);
    Uri uir = Uri(
      queryParameters: params,
      host: _serverUrl.host,
      // port: _serverUrl.port,
      scheme: _serverUrl.scheme,
      path: _serverUrl.path + command,
    );
    log(uir.toString());
    log("Service DELETE => $command body => ${jsonEncode(params)}");
    return http.delete(uir, headers: {
      "Content-Type": "text/plain",
      "token": await _token()
    }).then((value) {
      log("Service DELETE <= $command body => ${value?.body ?? 'no body'}");
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
      // port: _serverUrl.port,
      host: _serverUrl.host,
      scheme: _serverUrl.scheme,
      path: _serverUrl.path + command,
    );
    log(uir.toString());
    log("Service GET => $command body => ${jsonEncode(params)}");
    return http.get(uir, headers: {
      "Content-Type": "text/plain",
      "token": await _token()
    }).then((value) {
      log("Service GET <= $command? body => ${value?.body ?? 'no body'}");
      return Future.delayed(delay).then((_) => value);
    });
  }
}
