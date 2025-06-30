import 'package:flutter/material.dart';
import 'Screens/auth/login_Page.dart';
import 'Screens/home/home_page.dart'; // تأكد من استيراد صفحة Home

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const bool skipLogin = true; // نستخدم static const عشان نقدر نستخدمه هنا

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: skipLogin ? const HomePage() : const LoginPage(),
       // هنا التبديل
    );
  }
}
