
import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
class HttpHelper {
  static String getUserAgent(){
    // if (ValidateHelper.isNullOrEmpty(Application!.imei))
    //   return "StruckApplication";
    // return "StruckApplication/Imei=" + Application.imei;
    return '';
  }

  static Map<String, dynamic> processBody(Map<String, dynamic> body){
    if (body == null) {
      body = Map<String, dynamic>();
    }

    /*if (Application.loginInfo != null) {
      if (!body.containsKey("phoneNumber"))
        body["phoneNumber"] = Application.loginInfo.phoneNumber;

      if (!body.containsKey("phoneNumber"))
        body["password"] = Application.loginInfo.password;
    }*/

    return body;
  }

  static Map<String, String> processHeaders( Map<String, String> headers){

    if (!headers.containsKey("User-Agent")) {
      headers["User-Agent"] = getUserAgent();
    }

    return headers;
  }

  static String getQueryString(Map<String, dynamic> params, {String prefix: '&', bool inRecursion: false}) {

    String query = '';

    params.forEach((key, value) {

      if (inRecursion) {
        key = '[$key]';
      }

      if (value is String || value is int || value is double || value is bool) {
        query += '$prefix$key=$value';
      } else if (value is List || value is Map) {
        if (value is List) value = value.asMap();
        value.forEach((k, v) {
          query += getQueryString({k: v}, prefix: '$prefix$key', inRecursion: true);
        });
      }
    });

    return query;
  }

  static Future<Response> payload(String url, {Map<String, dynamic> ?body,  Map<String, dynamic>? headers}){
    ////print("asdsadas");
    //print("asdsadas");
    //print(body);
    body = processBody(body!);
    var jsonBody = json.encode(body);
    //print(jsonBody);
    if (kDebugMode) {
      print("Sending payload data to $url");
    }
    if (kDebugMode) {
      print("Data: $jsonBody");
    }

    // headers = processHeaders(headers);
    // if (!headers.containsKey("Content-Type")) {
    //   headers["Content-Type"] = "application/json";
    // }
    //
    // if (!headers.containsKey("Accept")) {
    //   headers["Accept"] = "application/json";
    // }
    final uri = Uri.parse(url);
    return http.Client().post(uri, headers: {
      "Content-Type": "application/json",
      'Accept':"application/json"
    } ,body: jsonBody).catchError((error) {
      //print("Send payload data to $url error!!!");
      //print(error);
    });
  }

  // static Future<Response> post(String url, {Map<String, dynamic> ?body, Map<String, dynamic>? headers}){
  //   //print("Sending payload data to $url");
  //   //print(body);
  //   // return http.Client().post(url, headers: processHeaders(headers), body: processBody(body!)).catchError((error) {
  //     //print("Send payload data to $url error!!!");
  //     //print(error);
  //   });
  // }

  static Future<Response> get(String url, {Map<String, dynamic>? params, Map<String, dynamic>? headers}){
    if (!url.contains("?")) {
      url += "?Trangkhanh";
    }
    url += getQueryString(params!);
    if (kDebugMode) {
      print("Sending payload data to $url");
    }
    // return http.Client().get(url, headers: processHeaders(headers)).catchError((error) {
    final uri = Uri.parse(url);
    return http.Client().get(uri, ).catchError((error) {
      // //print("Send payload data to $url error!!!");
      // //print(error);
    });
  }
}