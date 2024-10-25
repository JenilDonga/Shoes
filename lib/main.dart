// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'pages/Loginpage.dart';
import 'pages/intro_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroPage(),
    );
  }
}



