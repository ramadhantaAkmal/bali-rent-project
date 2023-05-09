import 'package:bali_rent/views/routes/route.dart';
import 'package:bali_rent/views/ui/welcome_page/welcome_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "NotoSans",
        primarySwatch: Colors.blue,
      ),
      routerConfig: router,
    );
  }
}
