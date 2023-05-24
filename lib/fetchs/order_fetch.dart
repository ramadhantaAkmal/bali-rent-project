import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class OrderApi {
  static const String url = 'http://10.0.2.2:3000/api/orders';

  static getOrders() async {
    try {
      Uri a = Uri.parse(url);

      final response = await http.get(
        a,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        final body = json.decode(response.body);
        return body;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        final statusCode = response.statusCode;
        return "error status code: $statusCode";
      }
    } catch (e) {
      return "error";
    }
  }

  static inputOrder(
    String bank,
    String dateToday,
    String startDate,
    String finishDate,
    int carId,
    int amount,
    String token,
  ) async {
    try {
      String register = url;

      final response = await http.post(
        Uri.parse(register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'access_token': token,
        },
        body: jsonEncode(<String, dynamic>{
          'orderDate': dateToday,
          'startDate': startDate,
          'finishDate': finishDate,
          'carId': carId,
          'amount': amount,
          'payment': bank,
        }),
      );
      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        return body;
      } else {
        final statusCode = response.statusCode;
        final body = json.decode(response.body);
        final message = body["message"];
        log("error code: $statusCode");
        return message;
      }
    } catch (e) {
      return e;
    }
  }

  static checkStatus(String id, String token) async {
    try {
      String checkLink = "$url/$id";

      final response = await http.post(
        Uri.parse(checkLink),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'access_token': token,
        },
      );
      if (response.statusCode == 201) {
        final body = json.decode(response.body);
        return body;
      } else {
        final statusCode = response.statusCode;
        final body = json.decode(response.body);
        final message = body["message"];
        log("error code: $statusCode");
        return message;
      }
    } catch (e) {
      return e;
    }
  }

  static deleteOrder(int id) async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = json.decode(pref.getString("token")!);
      var accessToken = token["access_token"];

      String checkLink = "$url/$id";

      final response = await http.delete(
        Uri.parse(checkLink),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'access_token': accessToken,
        },
      );
      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        return body;
      } else {
        final statusCode = response.statusCode;
        final body = json.decode(response.body);
        final message = body["message"];
        log("error code: $statusCode");
        return message;
      }
    } catch (e) {
      return e;
    }
  }
}
