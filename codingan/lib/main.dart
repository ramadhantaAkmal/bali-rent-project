import 'package:bali_rent/views/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Bali Rent',
      theme: ThemeData(
        fontFamily: "NotoSans",
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
