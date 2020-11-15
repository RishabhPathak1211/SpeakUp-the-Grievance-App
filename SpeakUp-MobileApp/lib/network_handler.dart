import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class NetworkHandler {
  FlutterSecureStorage storage = FlutterSecureStorage();
  String baseurl = "http://10.0.2.2:8000";
  var log = Logger();
  Future get(String url) async {
    String token = await storage.read(key: "token");
    url = formater(url);
    // /user/register
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formater(url);
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    print("ok");
    return response;
  }

  // Future<http.Response> post(String url, Map<String, String> body) async {
  //   String token = await storage.read(key: "token");
  //   url = formater(url);
  //   log.d(body);
  //   var response = await http.post(
  //     url,
  //     headers: {
  //       "Content-type": "application/json",
  //       "Authorization": "Bearer $token"
  //     },
  //     body: json.encode(body),
  //   );
  //   return response;
  // }

  String formater(String url) {
    return baseurl + url;
  }
}
