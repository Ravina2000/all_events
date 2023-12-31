import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiProvider {
  static Future<http.Response> getAPI(String url) async {
    final response = await http.get(Uri.parse(url));
    return response;
  }

  static Future<http.Response> postAPI(
      String url, Map<String, dynamic> param) async {
    final response = await http.post(Uri.parse(url), body: jsonEncode(param));
    return response;
  }
}