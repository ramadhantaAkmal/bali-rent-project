import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user_models/user.dart';

class UserApi {
  static const String url = 'http://10.0.2.2:3000/api/users';

  static getuser(String accessToken) async {
    try {
      Uri a = Uri.parse('$url/detail/');

      final response = await http.get(
        a,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'access_token': accessToken,
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
        final body = json.decode(response.body);
        return body;
      } else {
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
        return "New Account has been created";
      } else {
        final statusCode = response.statusCode;
        final body = json.decode(response.body);
        final message = body["message"];
        log("error code: $statusCode");
        return message;
      }
    } catch (e) {
      return "error";
    }
  }

  static userChangePass(String oldPass, String newPass, String confirmNewPass,
      String accessToken) async {
    try {
      String changePass = '$url/changePassword/';
      final response = await http.put(
        Uri.parse(changePass),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'access_token': accessToken,
        },
        body: jsonEncode(<String, String>{
          'newPassword': newPass,
          'confirmPassword': confirmNewPass,
          'password': oldPass
        }),
      );

      if (response.statusCode == 200) {
        final body = json.decode(response.body);
        final message = body["message"];
        return message;
      } else {
        final statusCode = response.statusCode;
        final body = json.decode(response.body);
        final message = body["message"];
        log("error code: $statusCode");
        return "failed";
      }
    } catch (e) {
      return e;
    }
  }

  static userUpdate(
      UserModel user, XFile? imgFile, int id, String accessToken) async {
    try {
      String userId = id.toString();
      String updateURL = '$url/';
      final uri = Uri.parse(updateURL);

      final requestBody = <String, String>{
        'name': user.nama,
        'username': user.username,
        'email': user.email,
        'phoneNumber': user.phoneNumber,
      };

      http.BaseResponse response;
      if (imgFile == null) {
        final headers = <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'access_token': accessToken,
        };
        response = await http.put(
          uri,
          headers: headers,
          body: jsonEncode(requestBody),
        );
      } else {
        File imageFile = File(imgFile.path);

        final imageBytes = await imageFile.readAsBytes();

        final headers = <String, String>{
          'access_token': accessToken,
        };

        // Create a multipart request
        var request = http.MultipartRequest('PUT', uri);

        request.headers.addAll(headers);

        // Add the image file to the request
        request.files.add(http.MultipartFile.fromBytes(
          'profilePicture',
          imageBytes,
          filename: 'image$userId.jpg',
          contentType: MediaType('image', 'jpeg'),
        ));

        request.fields.addAll(requestBody);
        // Send the request
        response = await request.send();
      }

      if (response.statusCode == 200) {
        final statusCode = response.statusCode;
        log("http code: $statusCode");
        return "Update Success";
      }

      final statusCode = response.statusCode;
      log("error code: $statusCode");
      return "Update Faileds";
    } catch (e) {
      return e;
    }
  }
}
