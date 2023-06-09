import 'dart:convert';
import 'dart:developer';

import 'package:bali_rent/style.dart';
import 'package:bali_rent/viewmodel/user_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../fetchs/user_fetch.dart';

class LoginMain extends ConsumerStatefulWidget {
  const LoginMain({super.key});

  @override
  ConsumerState<LoginMain> createState() => _LoginMainState();
}

class _LoginMainState extends ConsumerState<LoginMain> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    ref.read(userProvider);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    final result = await UserApi.userLogin(
        _usernameController.text, _passwordController.text);

    // print(result);
    if (result is String) {
      log(result);
    } else {
      SharedPreferences pref = await SharedPreferences.getInstance();
      await pref.setString('token', jsonEncode(result));
      ref.read(userProvider.notifier).getUserData();
      context.pushReplacement('/homescreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    var user = ref.watch(userProvider);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  bool _isHiddenPass = true;

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
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
              offset: const Offset(6, 4), // changes position of shadow
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
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 61),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/login-register-frame-design.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text.rich(
            TextSpan(
              style: TextStyle(fontSize: 24),
              children: [
                TextSpan(text: ' Sign ', style: TextStyle(color: primaryColor)),
                TextSpan(text: 'In', style: TextStyle(color: themeColor)),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 2,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: primaryColor,
                      )),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: primaryColor,
                      )),
                      border: const OutlineInputBorder(),
                      labelText: 'Username/Email',
                      // The MaterialStateProperty's value is a text style that is orange
                      // by default, but the theme's error color if the input decorator
                      // is in its error state.
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                        final Color color = states.contains(MaterialState.error)
                            ? Theme.of(context).colorScheme.error
                            : Colors.grey;
                        return TextStyle(color: color, letterSpacing: 1.3);
                      }),
                    ),
                    validator: (String? value) {
                      if (value == null || value == '') {
                        return 'Enter username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: _isHiddenPass,
                    cursorColor: primaryColor,
                    decoration: InputDecoration(
                      suffixIconColor: primaryColor,
                      enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: primaryColor,
                      )),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                        color: primaryColor,
                      )),
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            _isHiddenPass = !_isHiddenPass;
                          });
                        },
                        child: Icon(
                          _isHiddenPass
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                      ),
                      floatingLabelStyle: MaterialStateTextStyle.resolveWith(
                          (Set<MaterialState> states) {
                        final Color color = states.contains(MaterialState.error)
                            ? Theme.of(context).colorScheme.error
                            : Colors.grey;
                        return TextStyle(color: color, letterSpacing: 1.3);
                      }),
                    ),
                    validator: (String? value) {
                      if (value == null || value == '') {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: MaterialButton(
                      onPressed: () async {
                        _login();
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: primaryColor,
                      child: const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const Text('Don`t have account yet?',
                      textAlign: TextAlign.center),
                  TextButton(
                    onPressed: () {
                      context.push('/homescreen/login/register');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
