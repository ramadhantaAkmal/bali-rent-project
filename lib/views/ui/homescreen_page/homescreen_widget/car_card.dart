import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          onTap: () {
            context.push('/homescreen/detail');
          },
          splashColor: Colors.black,
        ),
      ),
    );
  }
}
