import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileMain extends StatelessWidget {
  const ProfileMain({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 38),
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
                    radius: 45,
                    backgroundImage: AssetImage('assets/images/emptypp.jpg'),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'M Akmal R',
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('+62xxxxxxxx'),
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
                  vertical: 50,
                  horizontal: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _rowMenuBuilder(
                        context, 'Edit Profile', Icons.person_rounded, () {
                      context.push('/homescreen/editprofile');
                    }),
                    const Divider(height: 20, thickness: 1),
                    _rowMenuBuilder(context, 'Change Password', Icons.lock, () {
                      context.push('/homescreen/changepass');
                    }),
                    const Divider(height: 20, thickness: 1),
                    _rowMenuBuilder(context, 'About Us', Icons.info_rounded,
                        () {
                      context.push('/homescreen/about');
                    }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
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
