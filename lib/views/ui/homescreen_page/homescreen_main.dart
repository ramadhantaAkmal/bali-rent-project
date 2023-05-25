import 'dart:convert';

import 'package:bali_rent/style.dart';
import 'package:bali_rent/views/ui/orders_page/orders_main.dart';
import 'package:bali_rent/views/ui/profile_page/profile_main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import '../../../viewmodel/brand_providers.dart';
import '../../../viewmodel/car_providers.dart';
import '../../../viewmodel/history_providers.dart';
import 'homepage.dart';

class HomescreenMain extends ConsumerStatefulWidget {
  const HomescreenMain({super.key});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_HomescreenMainState>()?.restartApp();
  }

  @override
  ConsumerState<HomescreenMain> createState() => _HomescreenMainState();
}

class _HomescreenMainState extends ConsumerState<HomescreenMain> {
  int _selectedIndex = 0;
  Key key = UniqueKey();

  final screenBody = [
    const Homepage(),
    const OrdersMain(),
    const ProfileMain(),
  ];

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    ref.read(brandProvider);
    ref.read(carProvider);
    ref.read(historyProvider);
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      ref.read(brandProvider.notifier).getBrands();
      ref.read(carProvider.notifier).getCars();
      ref.read(historyProvider.notifier).getOrders();
    });
  }

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

    // try catch and token variable used to check if token exist
    try {
      var token = jsonDecode(pref.getString("token")!);
      setState(() {
        _selectedIndex = index;
      });
    } catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Sorry!',
            message: 'You need to login first!',

            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
            contentType: ContentType.warning,
          ),
          behavior: SnackBarBehavior.floating,
          elevation: 0,
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
