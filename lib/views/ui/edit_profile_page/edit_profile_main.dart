import 'dart:convert';
import 'dart:io';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bali_rent/fetchs/user_fetch.dart';
import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/user_models/user.dart';
import '../../../viewmodel/user_providers.dart';

class EditProfileMain extends ConsumerStatefulWidget {
  const EditProfileMain({super.key});

  @override
  ConsumerState<EditProfileMain> createState() => _EditProfileMainState();
}

class _EditProfileMainState extends ConsumerState<EditProfileMain> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _nameController;
  late TextEditingController _phoneNumController;
  late TextEditingController _emailController;
  final formKey = GlobalKey<FormState>();

  XFile? _imageFile;
  ImageProvider? _imagePicked;
  final ImagePicker _picker = ImagePicker();

  bool _isHiddenPass = true;

  @override
  void initState() {
    super.initState();
    ref.read(userProvider);
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _nameController = TextEditingController();
    _phoneNumController = TextEditingController();
    _emailController = TextEditingController();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final userRef = ref.read(userProvider);
      _usernameController.text = userRef.username;
      _nameController.text = userRef.nama;
      _phoneNumController.text = userRef.phoneNumber;
      _emailController.text = userRef.email;
    });
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

  void _takePhoto() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SizedBox(
            height: 150,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: [
                InkWell(
                  onTap: () async {
                    _imageFile =
                        await _picker.pickImage(source: ImageSource.camera);
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: const [
                        Icon(Icons.photo_camera),
                        Text(' Take picture from Camera '),
                      ],
                    ),
                  ),
                ),
                const Divider(),
                InkWell(
                  onTap: () async {
                    _imageFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    setState(() {});
                  },
                  child: SizedBox(
                    height: 50,
                    child: Row(
                      children: const [
                        Icon(Icons.photo_library),
                        Text(' Browse from gallery '),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          );
        });
  }

  void _updateProfile(String nama, String email, String phoneNumber,
      String username, String password, XFile? imgFile) async {
    try {
      if (password != "") {
        SharedPreferences pref = await SharedPreferences.getInstance();
        var token = json.decode(pref.getString("token")!);
        UserModel user = UserModel(
          nama: nama,
          email: email,
          phoneNumber: phoneNumber,
          profilePicture: "",
          username: username,
          password: password,
        );
        var result = await UserApi.userUpdate(
            user, imgFile, token["id"], token["access_token"]);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Success!',
              message: result,

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.success,
            ),
            behavior: SnackBarBehavior.floating,
            elevation: 0,
          ),
        );
        context.pushReplacement('/homescreen');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Password invalid!',
              message: 'You need to insert password!',

              /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
              contentType: ContentType.warning,
            ),
            behavior: SnackBarBehavior.floating,
            elevation: 0,
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userRef = ref.watch(userProvider);
    if (_imageFile == null) {
      _imagePicked = NetworkImage(userRef.profilePicture);
    } else {
      _imagePicked = FileImage(File(_imageFile!.path));
    }
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: themeColor,
      appBar: _buildAppBar(context),
      body: _buildBody(context, userRef),
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

  Widget _buildBody(BuildContext context, UserModel userRef) {
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
                    color: backgroundColor,
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
                  child: CircleAvatar(
                    radius: 35,
                    backgroundImage: _imagePicked,
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
                          onPressed: () {
                            _takePhoto();
                          },
                          icon: const Icon(Icons.mode_edit_outline),
                          splashRadius: 17,
                          color: primaryColor,
                        ),
                      ],
                    ),
                    const Text(
                      'Edit Profile Picture',
                      style: TextStyle(
                        color: secondaryColor,
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
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                  ),
                  BoxShadow(
                    color: backgroundColor,
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
                          cursorColor: primaryColor,
                          obscureText: _isHiddenPass,
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
                            suffixIconColor: primaryColor,
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
                            onPressed: () {
                              _updateProfile(
                                _nameController.text,
                                _emailController.text,
                                _phoneNumController.text,
                                _usernameController.text,
                                _passwordController.text,
                                _imageFile,
                              );
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: primaryColor,
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
