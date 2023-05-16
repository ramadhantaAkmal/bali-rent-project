import 'package:bali_rent/style.dart';
import 'package:bali_rent/views/ui/orders_page/orders_widget/order_card.dart';
import 'package:flutter/material.dart';

class OrdersMain extends StatelessWidget {
  const OrdersMain({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: _builAppBar(context),
        body: _buildBody(context),
      ),
    );
  }

  AppBar _builAppBar(BuildContext context) {
    return AppBar(
      elevation: 2,
      bottomOpacity: 1.0,
      backgroundColor: themeColor,
      automaticallyImplyLeading: false,
      title: const Text(
        'Order History',
        style: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TabBar(
          tabs: [
            Tab(
              text: 'Active',
            ),
            Tab(
              text: 'Upcoming (x)',
            ),
            Tab(text: 'History (x)'),
          ],
          labelColor: primaryColor,
          unselectedLabelColor: Colors.black,
          dividerColor: primaryColor,
          padding: EdgeInsets.only(top: 18, left: 13, right: 30),
          labelStyle: TextStyle(overflow: TextOverflow.visible),
          unselectedLabelStyle: TextStyle(
            overflow: TextOverflow.visible,
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: MediaQuery.of(context).size.height,
            width: 350,
            child: ListView.builder(
              itemBuilder: (context, index) {
                return const OrderCard();
              },
              shrinkWrap: true,
              itemCount: 10,
            ),
          ),
        ),
      ],
    );
  }
}
