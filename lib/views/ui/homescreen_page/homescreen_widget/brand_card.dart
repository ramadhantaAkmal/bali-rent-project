import 'package:bali_rent/style.dart';
import 'package:flutter/material.dart';

class BrandCard extends StatelessWidget {
  const BrandCard(this.image, {super.key});
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.grey),
      ),
      width: 70,
      margin: const EdgeInsets.all(5),
      child: Image(fit: BoxFit.scaleDown, image: NetworkImage(image)),
    );
  }
}
