import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

abstract class ResponseError {
  static Future<String> getMessage(String body) async {
    dynamic res = jsonDecode(body);
    return "$res";
  }

  static Future<String> processError({http.Response response}) async {
    return await getMessage(response.body).catchError((error) {
      log("Server error ${response?.statusCode}");
      return "Server error ${response?.statusCode}";
    });
  }
}
