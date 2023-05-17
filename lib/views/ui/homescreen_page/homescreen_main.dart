import 'dart:convert';

import 'package:bali_rent/style.dart';
import 'package:bali_rent/views/ui/orders_page/orders_main.dart';
import 'package:bali_rent/views/ui/profile_page/profile_main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'homepage.dart';

class HomescreenMain extends StatefulWidget {
  const HomescreenMain({super.key});

  @override
  State<HomescreenMain> createState() => _HomescreenMainState();
}

class _HomescreenMainState extends State<HomescreenMain> {
  int _selectedIndex = 0;

  final screenBody = [
    const Homepage(),
    const OrdersMain(),
    const ProfileMain(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: themeColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: screenBody,
      ),
      bottomNavigationBar: _buildBottomNavbar(context),
    );
  }

  void _onItemTapped(int index) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    // try catch used to check if token exist
    try {
      var token = jsonDecode(pref.getString("token")!);
      setState(() {
        _selectedIndex = index;
      });
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('You need to login first'),
          backgroundColor: primaryColor,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 30, right: 20, left: 20),
          showCloseIcon: true,
        ),
      );
      if (index != 0) {
        context.push('/homescreen/login');
      }
    }
  }

  Widget _buildBottomNavbar(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.text_snippet),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
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
