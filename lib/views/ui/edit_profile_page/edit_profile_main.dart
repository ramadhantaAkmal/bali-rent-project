import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EditProfileMain extends StatefulWidget {
  const EditProfileMain({super.key});

  @override
  State<EditProfileMain> createState() => _EditProfileMainState();
}

class _EditProfileMainState extends State<EditProfileMain> {
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

  bool _isHiddenPass = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: themeColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      resizeToAvoidBottomInset: true,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
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
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 38, top: 10, left: 30, right: 30),
            child: Row(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(
                          4,
                          9,
                        ),
                        blurRadius: 12,
                        color: Colors.black45,
                        spreadRadius: 1,
                      )
                    ],
                  ),
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundImage: AssetImage('assets/images/emptypp.jpg'),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                          bottom: 9,
                          left: 9,
                          child: ClipOval(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              color: Colors.white,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.mode_edit_outline),
                          splashRadius: 17,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    const Text(
                      'Edit Profile Picture',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    spreadRadius: 0,
                    blurRadius: 4.0,
                    offset: Offset(
                      0,
                      4.0,
                    ),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 30,
                ),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
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
                            floatingLabelStyle:
                                MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                              final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.grey;
                              return TextStyle(
                                  color: color, letterSpacing: 1.3);
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
                            floatingLabelStyle:
                                MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                              final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.grey;
                              return TextStyle(
                                  color: color, letterSpacing: 1.3);
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
                            floatingLabelStyle:
                                MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                              final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.grey;
                              return TextStyle(
                                  color: color, letterSpacing: 1.3);
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
                            floatingLabelStyle:
                                MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                              final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.grey;
                              return TextStyle(
                                  color: color, letterSpacing: 1.3);
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
                          height: 60,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isHiddenPass,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Password Verification',
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
                            floatingLabelStyle:
                                MaterialStateTextStyle.resolveWith(
                                    (Set<MaterialState> states) {
                              final Color color =
                                  states.contains(MaterialState.error)
                                      ? Theme.of(context).colorScheme.error
                                      : Colors.grey;
                              return TextStyle(
                                  color: color, letterSpacing: 1.3);
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
                          height: 15,
                        ),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 35),
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: MaterialButton(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: Colors.blueAccent,
                            child: const Text(
                              'UPDATE PROFILE',
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
