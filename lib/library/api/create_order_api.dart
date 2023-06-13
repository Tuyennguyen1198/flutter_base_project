import 'dart:convert';

import '../helper/http_helper.dart';
import 'api_url.dart';

class CreateOrderApi {
  bool? isStatus;
  String? message;
  dynamic data;

  CreateOrderApi({this.isStatus, this.message, this.data});

  factory CreateOrderApi.fromJson(String? username, String? password,
      Map<String, dynamic> json) {
    bool isSuccess = json["isStatus"];
    if (!isSuccess) {
      return CreateOrderApi(isStatus: isSuccess, message: json["message"]);
    }
    //(json["data"]);
    var data = json["data"];
    var message = json["message"];
    return CreateOrderApi(isStatus: isSuccess, data: data, message: message);
  }
  static Future<CreateOrderApi> getMessageChatMobile() async {
    var response = await HttpHelper.get(ApiUrls.getMessageChatMobile, params: {
      "username":"",
      "password":"",
    });
    //(response.statusCode);
    if (response.statusCode == 200) {
      Map<String, dynamic> mapResponse = json.decode(response.body);
      return CreateOrderApi.fromJson("", "", mapResponse);
    } else {
      throw Exception("Failed to send request!!!");
    }
  }
}