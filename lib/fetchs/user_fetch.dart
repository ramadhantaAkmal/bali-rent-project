import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';

class UserApi {
  static const String url = 'http://10.0.2.2:3000/api/users';

  static getuser(int userId) async {
    try {
      Uri a = Uri.parse('$url/$userId');
      final response = await http.get(a);
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

  static userLogin(String username, String password) async {
    try {
      String login = '$url/login';
      final response = await http.post(
        Uri.parse(login),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, String>{'login': username, 'password': password}),
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

  static userRegister(UserModel user) async {
    try {
      String register = url;
      final response = await http.post(
        Uri.parse(register),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': user.nama,
          'username': user.username,
          'email': user.email,
          'password': user.password,
          'phoneNumber': user.phoneNumber,
        }),
      );
      if (response.statusCode == 201) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.

        return "New Account has been created";
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        final statusCode = response.statusCode;
        final body = json.decode(response.body);
        final message = body["message"];
        print("error code: $statusCode");
        return message;
      }
    } catch (e) {
      return "error";
    }
  }
}
