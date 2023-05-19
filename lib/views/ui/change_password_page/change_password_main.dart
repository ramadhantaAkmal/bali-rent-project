import 'dart:convert';

import 'package:bali_rent/fetchs/user_fetch.dart';
import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassMain extends StatefulWidget {
  const ChangePassMain({super.key});

  @override
  State<ChangePassMain> createState() => _ChangePassMainState();
}

class _ChangePassMainState extends State<ChangePassMain> {
  final formKey = GlobalKey<FormState>();
  late TextEditingController _oldPasswordController;
  late TextEditingController _newPasswordController;
  late TextEditingController _repeatPasswordController;

  @override
  void initState() {
    super.initState();
    _oldPasswordController = TextEditingController();
    _newPasswordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _repeatPasswordController.dispose();
    super.dispose();
  }

  bool _isHiddenOldPass = true;
  bool _isHiddenNewPass = true;
  bool _isHiddenRepeatPass = true;
  bool _isBtnDisabled = true;
  bool _isFieldEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  void _onFormChanged(String value) {
    if (value != '') {
      _isBtnDisabled = false;
      _isFieldEnabled = true;
    } else {
      _isBtnDisabled = true;
      _isFieldEnabled = false;
    }
  }

  void _changePass(
      String oldPass, String newPass, String confirmNewPass) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var token = json.decode(pref.getString("token")!);
    var result = await UserApi.userChangePass(
        oldPass, newPass, confirmNewPass, token["id"]);
    print(result);
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: themeColor,
      leading: Container(
        margin: const EdgeInsets.only(left: 7, top: 4, right: 10, bottom: 10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(
            Radius.circular(15.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 11,
              offset: const Offset(6, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(3.0),
          child: Center(
            child: IconButton(
              iconSize: 20,
              onPressed: () {
                context.pop();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Old Password',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: _isHiddenOldPass,
                  controller: _oldPasswordController,
                  decoration: InputDecoration(
                    hintText: 'Input Old Password',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusColor: primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isHiddenOldPass = !_isHiddenOldPass;
                        });
                      },
                      child: Icon(
                        _isHiddenOldPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'New Password',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: _isHiddenNewPass,
                  controller: _newPasswordController,
                  onChanged: (value) {
                    _onFormChanged(value);
                  },
                  decoration: InputDecoration(
                    hintText: 'Input New Password',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusColor: primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isHiddenNewPass = !_isHiddenNewPass;
                        });
                      },
                      child: Icon(
                        _isHiddenNewPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'Repeat Password',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: _isHiddenRepeatPass,
                  controller: _repeatPasswordController,
                  enabled: _isFieldEnabled,
                  decoration: InputDecoration(
                    hintText: 'Repeat New Password',
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    focusColor: primaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          _isHiddenRepeatPass = !_isHiddenRepeatPass;
                        });
                      },
                      child: Icon(
                        _isHiddenRepeatPass
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: MaterialButton(
              onPressed: _isBtnDisabled
                  ? null
                  : () {
                      _changePass(
                        _oldPasswordController.text,
                        _newPasswordController.text,
                        _repeatPasswordController.text,
                      );
                    },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: primaryColor,
              disabledColor: Colors.grey,
              child: const Text(
                'SAVE',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
