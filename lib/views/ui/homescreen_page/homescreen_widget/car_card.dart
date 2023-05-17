import 'dart:convert';

import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarCard extends StatelessWidget {
  const CarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
        ),
        width: 202,
        margin: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();

            // try catch used to check if token exist
            try {
              var token = jsonDecode(pref.getString("token")!);
              context.push('/homescreen/detail');
            } catch (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('You need to login first!'),
                  backgroundColor: primaryColor,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.only(bottom: 30, right: 20, left: 20),
                  showCloseIcon: true,
                ),
              );
              context.push('/homescreen/login');
            }
          },
          splashColor: Colors.black,
        ),
      ),
    );
  }
}
