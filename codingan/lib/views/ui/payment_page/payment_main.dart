import 'package:bali_rent/viewmodel/order_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../style.dart';

class PaymentMain extends ConsumerWidget {
  const PaymentMain({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context, ref),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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

  Widget _buildBody(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Text(
            'Choose one of this payment method to generate VA numbers',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          _buildImage(
              'BCA',
              const Image(
                image: AssetImage('assets/images/bca.jpg'),
                fit: BoxFit.contain,
              ),
              context,
              ref),
          const SizedBox(
            height: 10,
          ),
          _buildImage(
              'permata',
              const Image(
                image: AssetImage('assets/images/permata-bank-vector-logo.png'),
                fit: BoxFit.contain,
              ),
              context,
              ref),
        ],
      ),
    );
  }

  Widget _buildImage(
      String method, Image imagePath, BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(15.0)),
      onTap: (() {
        ref.watch(orderProvider.notifier).addOrder(method);
        context.push('/homescreen/detail/order/method/payment');
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
        height: 80,
        width: 325,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
          child: imagePath,
        ),
      ),
    );
  }
}
