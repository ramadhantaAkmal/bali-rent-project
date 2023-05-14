import 'package:flutter/material.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.5),
        ),
        height: 170,
        margin: const EdgeInsets.all(5),
        child: InkWell(
          onTap: () {},
          splashColor: Colors.black,
        ),
      ),
    );
  }
}
