import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../models/car_models/car.dart';
import '../../../../viewmodel/detail_providers.dart';

class CarListCard extends ConsumerWidget {
  const CarListCard(this.car, {super.key});
  final CarModel car;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
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
            // try catch and token variable used to check if token exist
            try {
              var token = jsonDecode(pref.getString("token")!);
              ref
                  .read(detailProvider.notifier)
                  .getCarDetails(car, car.rentHouse["id"]);
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
          child: Row(
            children: [
              Container(
                height: 120,
                width: 150,
                decoration: BoxDecoration(
                    //Car image
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(car.carImage)),
                    color: backgroundColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey),
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        blurStyle: BlurStyle.solid,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ]),
              ),
              Flexible(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  height: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Car Name
                      Text(
                        car.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      //car address
                      AutoSizeText(
                        car.rentHouse["address"],
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.grey,
                          fontSize: 11,
                        ),
                        minFontSize: 2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      Text(
                        car.status,
                        style: TextStyle(
                          fontSize: 18,
                          color: car.status == "Available"
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                      AutoSizeText.rich(
                        //car price
                        TextSpan(children: [
                          const TextSpan(text: "From "),
                          TextSpan(
                              text: NumberFormat.currency(
                                locale: 'id',
                                symbol: 'Rp ',
                                decimalDigits: 2,
                              ).format(car.rentPrice),
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold)),
                          const TextSpan(text: "/day"),
                        ]),
                        style: const TextStyle(
                            fontFamily: 'Poppins', color: primaryColor),
                        minFontSize: 2,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
