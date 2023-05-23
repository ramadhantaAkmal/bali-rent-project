import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class OrderApi {
  static const String url = 'http://10.0.2.2:3000/api/orders';

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
          'orderDate': "2023-05-09 20:30:49.433",
          'startDate': "2023-05-09 20:30:49.433",
          'finishDate': "2023-05-10 20:30:49.433",
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
}
