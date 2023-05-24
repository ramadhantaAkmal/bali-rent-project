import 'dart:convert';

import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/brand_models/brand.dart';
import '../../../models/car_models/car.dart';
import '../../../viewmodel/brand_providers.dart';
import '../../../viewmodel/car_providers.dart';
import 'homescreen_widget/brand_card.dart';
import 'homescreen_widget/car_card.dart';

class Homepage extends ConsumerStatefulWidget {
  const Homepage({super.key});

  @override
  ConsumerState<Homepage> createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  bool _login = true;

  @override
  void initState() {
    ref.read(brandProvider);
    ref.read(carProvider);
    SharedPreferences.getInstance().then(
      (pref) {
        var token = json.decode(pref.getString("token")!);

        if (token != null) {
          setLogin();
        }
      },
    );
    super.initState();
  }

  void setLogin() {
    setState(() {
      _login = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<BrandModel> userRef = ref.watch(brandProvider);
    final List<CarModel> carRef = ref.watch(carProvider);
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Bali Rent",
                  style: TextStyle(
                    color: titleColor,
                    fontFamily: 'IslandMoments',
                    fontSize: 42,
                  ),
                ),
                _login
                    ? TextButton(
                        onPressed: () {
                          context.push('/homescreen/login');
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: secondaryColor,
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Find Your Favorite Vehicle.",
              style: TextStyle(
                  color: secondaryColor,
                  fontFamily: 'NotoSans',
                  fontSize: 32,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 10,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8, bottom: 10),
                    child: Text(
                      'Available Brands',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 75,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          BrandCard(userRef[index].brandImage),
                      itemCount: userRef.length,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Available Cars',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.push('/homescreen/carlist');
                          },
                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 209,
                    color: backgroundColor,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => CarCard(carRef[index]),
                      itemCount: carRef.length,
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
