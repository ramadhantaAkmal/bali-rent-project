import 'package:bali_rent/models/user_models/user.dart';
import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../viewmodel/user_providers.dart';

class ProfileMain extends ConsumerStatefulWidget {
  const ProfileMain({super.key});

  @override
  ConsumerState<ProfileMain> createState() => _ProfileMainState();
}

class _ProfileMainState extends ConsumerState<ProfileMain> {
  @override
  void initState() {
    super.initState();
    ref.read(userProvider);
    ref.read(userProvider.notifier).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel userRef = ref.watch(userProvider);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: _buildAppBar(context),
      body: _buildBody(context, userRef),
      backgroundColor: themeColor,
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: [
        TextButton(
          onPressed: () async {
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.clear();
            context.pushReplacement('/');
          },
          child: const Text(
            'Sign Out',
            style: TextStyle(
              color: secondaryColor,
            ),
          ),
        )
      ],
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildBody(BuildContext context, UserModel user) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(bottom: 38, top: 70, right: 30, left: 30),
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
                child: CircleAvatar(
                  radius: 45,
                  backgroundImage: NetworkImage(user.profilePicture),
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.nama,
                    style: const TextStyle(
                      color: secondaryColor,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    user.phoneNumber,
                    style: const TextStyle(color: secondaryColor),
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
                  topLeft: Radius.circular(25), topRight: Radius.circular(25)),
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
                vertical: 50,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _rowMenuBuilder(context, 'Edit Profile', Icons.person_rounded,
                      () {
                    context.push('/homescreen/editprofile');
                  }),
                  const Divider(height: 20, thickness: 1),
                  _rowMenuBuilder(context, 'Change Password', Icons.lock, () {
                    context.push('/homescreen/changepass');
                  }),
                  const Divider(height: 20, thickness: 1),
                  _rowMenuBuilder(context, 'About Us', Icons.info_rounded, () {
                    context.push('/homescreen/about');
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _rowMenuBuilder(
      BuildContext context, String text, IconData icon, Function()? tap) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
        onTap: tap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios),
          ],
        ),
      ),
    );
  }
}
