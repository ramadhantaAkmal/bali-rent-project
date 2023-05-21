import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/car_models/car.dart';

class CarCard extends StatelessWidget {
  const CarCard(this.car, {super.key});
  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.grey),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurStyle: BlurStyle.solid,
              spreadRadius: 1,
              blurRadius: 2,
              offset: Offset(2, 2),
            ),
          ]),
      width: 220,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          splashFactory: InkSplash.splashFactory,
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            // try catch used to check if token exist
            try {
              var token = jsonDecode(pref.getString("token")!);
              context.push('/homescreen/detail');
            } catch (_) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.transparent,
                  content: AwesomeSnackbarContent(
                    title: 'Sorry!',
                    message: 'You need to login first!',
                    contentType: ContentType.warning,
                  ),
                  behavior: SnackBarBehavior.floating,
                  elevation: 0,
                ),
              );
              context.push('/homescreen/login');
            }
          },
          splashColor: Colors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: BoxDecoration(
                    //Car image
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(car.carImage)),
                    color: backgroundColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        blurStyle: BlurStyle.solid,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ]),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6),
                height: 89,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Car Name
                    Text(
                      car.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    //car address
                    AutoSizeText(
                      car.rentHouse["address"],
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                        fontSize: 11,
                      ),
                      minFontSize: 2,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text.rich(
                      //car price
                      TextSpan(children: [
                        TextSpan(text: "From "),
                        TextSpan(
                            text: NumberFormat.currency(
                              locale: 'id',
                              symbol: 'Rp ',
                              decimalDigits: 2,
                            ).format(car.rentPrice),
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextSpan(text: "/day"),
                      ]),
                      style:
                          TextStyle(fontFamily: 'Poppins', color: primaryColor),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
