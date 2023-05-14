import 'package:bali_rent/style.dart';
import 'package:bali_rent/views/ui/homescreen_page/homescreen_widget/brand_card.dart';
import 'package:bali_rent/views/ui/orders_page/orders_main.dart';
import 'package:bali_rent/views/ui/profile_page/profile_main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'homepage.dart';
import 'homescreen_widget/car_card.dart';

class HomescreenMain extends StatefulWidget {
  const HomescreenMain({super.key});

  @override
  State<HomescreenMain> createState() => _HomescreenMainState();
}

class _HomescreenMainState extends State<HomescreenMain> {
  int _selectedIndex = 0;

  final screenBody = [
    Homepage(),
    OrdersMain(),
    ProfileMain(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeColor,
      body: screenBody[_selectedIndex],
      bottomNavigationBar: _buildBottomNavbar(context),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildBottomNavbar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.text_snippet),
          label: 'Orders',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Profile',
        ),
      ],
      iconSize: 30,
      selectedFontSize: 18,
      showUnselectedLabels: false,
      currentIndex: _selectedIndex,
      selectedItemColor: primaryColor,
      onTap: _onItemTapped,
    );
  }
}
