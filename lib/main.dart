import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ABDTradersApp());
}

class ABDTradersApp extends StatelessWidget {
  const ABDTradersApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ABD Traders',
      theme: ThemeData.dark(),
      home: const SplashScreen(),
    );
  }
}