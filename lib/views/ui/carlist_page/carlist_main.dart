import 'package:bali_rent/style.dart';
import 'package:bali_rent/views/ui/carlist_page/carlist_widget/car_card.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarListMain extends StatelessWidget {
  const CarListMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(context),
    );
  }

  AppBar _buildAppbar(BuildContext context) {
    return AppBar(
      elevation: 1,
      backgroundColor: themeColor,
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
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  child: const TextField(
                    decoration: InputDecoration(
                      fillColor: secondaryColor,
                      prefixIconColor: secondaryColor,
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search Car ...',
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: OutlinedButton(
                  child: const Text(
                    "Filter",
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom(
                    alignment: Alignment.centerLeft,
                    fixedSize: const Size(73, 40),
                    side: const BorderSide(
                      strokeAlign: 10,
                      color: secondaryColor,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => const CarListCard(),
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}
