import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () async {
      Navigator.pushReplacementNamed(context, '/login');
      // Navigator.pushReplacementNamed(context, "/chat");
    });
    return Scaffold(
        body: Center(
      child: Image.asset('assets/images/아이콘 최종 핑크2_배경없음.png',
          width: MediaQuery.of(context).size.width * 0.6, fit: BoxFit.contain),
    ));
  }
}
