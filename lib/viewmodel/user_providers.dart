import 'dart:convert';

import 'package:bali_rent/fetchs/user_fetch.dart';
import 'package:bali_rent/models/user_models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNotifier extends StateNotifier<UserModel> {
  UserNotifier()
      : super(UserModel(
            nama: "",
            email: "",
            password: "",
            phoneNumber: "",
            username: "",
            profilePicture: ""));

  void getUserData() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      var token = json.decode(pref.getString("token")!);
      var userData = await UserApi.getuser(token["id"]);
      state = state.copyWith(
        nama: userData["name"],
        username: userData["username"],
        email: userData["email"],
        phoneNumber: userData["phoneNumber"],
        profilePicture: userData["profilePicture"],
      );
      print(state.nama);
    } catch (e) {
      print(e);
    }
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, UserModel>((ref) => UserNotifier());
