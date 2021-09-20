import 'dart:convert';

import 'package:custom_dialog/screens/add_parameters.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AllNewApis {
  String baseUrl = 'https://test.skywasolutions.com';

  Future<http.Response> createCustomAlert(
      {@required token, @required businessId, @required jsonBody}) async {
    http.Response response;
    //TODO: Uncomment all commented code when adding to manager
    // try {
    Uri uri = Uri.parse('$baseUrl/postCustomAlerts');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final params = {
      "alertUrl": jsonBody["alertUrl"] == null ? "" : jsonBody["alertUrl"],
      "alertImageUrl":
          jsonBody["alertImageUrl"] == null ? "" : jsonBody["alertImageUrl"],
      "alertPosition":
          jsonBody["alertPosition"] == null ? "joinQueue" : jsonBody["alertPosition"],
      "startDate": jsonBody["startDate"] == null ? "" : jsonBody["startDate"],
      "endDate": jsonBody["endDate"] == null ? "" : jsonBody["endDate"],
      "buttonText":
          jsonBody["buttonText"] == null ? "More Info" : jsonBody["buttonText"],
      "enableCancelString": jsonBody["enableCancelString"] == null
          ? "true"
          : jsonBody["enableCancelString"],
      "bulletSymbol":
          jsonBody["bulletSymbol"] == null ? "✓" : jsonBody["bulletSymbol"],
      "name": jsonBody["name"] == null ? "" : jsonBody["name"],
      "businessId": businessId,
      "queueName": jsonBody["queueName"] == null ? "Main Entrance" : jsonBody["queueName"],
      "status": jsonBody["status"] == null ? "inactive" : jsonBody["status"],
      "title": jsonBody["title"] == null ? "Title" : jsonBody["title"],
      "headerText":
          jsonBody["headerText"] == null ? "Welcome" : jsonBody["headerText"],
      "centerBulletText": jsonBody["centerBulletText"] == null
          ? ""
          : jsonBody["centerBulletText"],
      "footerText":
          jsonBody["footerText"] == null ? "" : jsonBody["footerText"],
      "emailAllowedString": jsonBody["emailAllowedString"] == null
          ? "false"
          : jsonBody["emailAllowedString"],
      "smsAllowedString": jsonBody["linkAllowedString"] == null
          ? "false"
          : jsonBody["linkAllowedString"],
      "phoneAllowedString": jsonBody["phoneAllowedString"] == null
          ? "false"
          : jsonBody["phoneAllowedString"],
      "email": jsonBody["email"] == null ? "" : jsonBody["email"],
      "smsNumber": jsonBody["link"] == null ? "" : jsonBody["link"],
      "phoneNumber":
          jsonBody["phoneNumber"] == null ? "" : jsonBody["phoneNumber"],
      "bgColor": SizeAndColors.bgColor==null?jsonBody["bgColor"] == null ? "0x6C71C4FF" : jsonBody["bgColor"]:SizeAndColors.bgColor.toString(),
      "titleColor": SizeAndColors.titleColor==null?
          jsonBody["titleColor"] == null ? "0xffffffff" : jsonBody["titleColor"]:SizeAndColors.titleColor.toString(),
      "msgColor": SizeAndColors.msgColor==null?jsonBody["msgColor"] == null ? "0x000000ff" : jsonBody["msgColor"]:SizeAndColors.msgColor.toString(),
      "titleFontString": jsonBody["titleFontString"] == null
          ? "18"
          : jsonBody["titleFontString"],
      "msgFontString":
          jsonBody["msgFontString"] == null ? "16" : jsonBody["msgFontString"],
    };
    String body = json.encode(params);

    response = await http.post(uri, headers: headers, body: body);
    // } catch (e) {
    //   navigate();
    //   return null;
    // }
    // if (response.statusCode >= 500) {
    //   navigate();
    //   return null;
    // }
    return response;
  }

  Future<http.Response> getCustomAlerts({
    @required token,
    @required businessId,
  }) async {
    http.Response response;
    // try {
    Uri uri = Uri.parse('$baseUrl/getCustomAlerts?businessId=$businessId');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    response = await http.get(uri, headers: headers);
    // } catch (e) {
    //   print("Catch in getBusinessById");
    //   navigate();
    //   return null;
    // }
    // if (response.statusCode >= 500) {
    //   print("500 in getBusinessById");
    //   navigate();
    //   return null;
    // }
    return response;
  }

  Future<http.Response> deleteCustomAlerts({
    @required token,
    @required businessId,
  }) async {
    http.Response response;
    // try {
    Uri uri = Uri.parse('$baseUrl/deleteCustomAlerts?businessId=$businessId');
    var headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    response = await http.delete(uri, headers: headers);
    // } catch (e) {
    //   navigate();
    //   return null;
    // }
    // if (response.statusCode >= 500) {
    //   navigate();
    //   return null;
    // }
    return response;
  }
}
