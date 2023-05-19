import 'package:bali_rent/fetchs/user_fetch.dart';
import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../models/user_models/user.dart';

class RegisterMain extends StatefulWidget {
  const RegisterMain({super.key});

  @override
  State<RegisterMain> createState() => _RegisterMainState();
}

class _RegisterMainState extends State<RegisterMain> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _phoneNumController;
  late TextEditingController _emailController;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _phoneNumController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _phoneNumController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _register({
    required String nama,
    required String email,
    required String phoneNumber,
    required String username,
    required String password,
  }) async {
    UserModel user = UserModel(
      nama: nama,
      email: email,
      phoneNumber: phoneNumber,
      username: username,
      password: password,
      profilePicture: "",
    );
    var result = await UserApi.userRegister(user);
    if (result == "New Account has been created") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 30, right: 20, left: 20),
          showCloseIcon: true,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 30, right: 20, left: 20),
          showCloseIcon: true,
        ),
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
          fit: BoxFit.fill,
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
                TextSpan(text: 'Up', style: TextStyle(color: themeColor)),
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
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Name',
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
                        return 'Enter Name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _phoneNumController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Phone Number',
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
                        return 'Enter Phone Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Email',
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
                        return 'Enter Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Username',
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
                        return 'Enter Username';
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
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'Password',
                      // The MaterialStateProperty's value is a text style that is orange
                      // by default, but the theme's error color if the input decorator
                      // is in its error state.
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
                      onPressed: () {
                        _register(
                          nama: _nameController.text,
                          email: _emailController.text,
                          phoneNumber: _phoneNumController.text,
                          username: _usernameController.text,
                          password: _passwordController.text,
                        );
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: Colors.blueAccent,
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
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
