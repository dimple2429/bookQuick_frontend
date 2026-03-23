import 'package:flutter/material.dart';

import 'features/auth/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      theme: ThemeData(
        primaryColor: Color(0xFF5FABBD),
        scaffoldBackgroundColor: Color(0xFFF5F7F9),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
        ),
      ),
    );
  }
}