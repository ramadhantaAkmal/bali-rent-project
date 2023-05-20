import 'dart:convert';

import 'package:http/http.dart' as http;

class BrandApi {
  static const String url = 'http://10.0.2.2:3000/api/brands';

  static getBrands() async {
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
        return "test";
      }
    } catch (e) {
      return "error";
    }
  }
}
