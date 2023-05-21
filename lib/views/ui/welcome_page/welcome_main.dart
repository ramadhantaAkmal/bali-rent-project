import 'package:bali_rent/models/brand_models/brand.dart';
import 'package:bali_rent/style.dart';
import 'package:bali_rent/viewmodel/car_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../viewmodel/brand_providers.dart';

class WelcomeMain extends ConsumerWidget {
  const WelcomeMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: buildBody(context, ref),
    );
  }

  Widget buildBody(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/temp.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        children: [
          const Spacer(
            flex: 8,
          ),
          const Text(
            "Bali Rent",
            style: TextStyle(
                fontFamily: 'IslandMoments', fontSize: 108, color: titleColor),
          ),
          const Spacer(
            flex: 3,
          ),
          const Text(
            "Rent your best car here!",
            style: TextStyle(
                fontFamily: 'GrandHotel', fontSize: 30, color: Colors.white),
          ),
          const Spacer(
            flex: 6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: TextButton(
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(const Size.fromHeight(50)),
                backgroundColor:
                    MaterialStateProperty.all(Colors.white.withOpacity(0.30)),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.all(10)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: titleColor),
                  ),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.white),
              ),
              onPressed: () {
                ref.read(brandProvider.notifier).getBrands();
                ref.read(carProvider.notifier).getCars();
                context.push('/homescreen');
              },
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}
