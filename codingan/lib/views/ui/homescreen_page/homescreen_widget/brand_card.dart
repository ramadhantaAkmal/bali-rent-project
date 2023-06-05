import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard(this.image, {super.key});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
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
      width: 70,
      margin: const EdgeInsets.all(5),
      child: Image(fit: BoxFit.scaleDown, image: NetworkImage(image)),
    );
  }
}
