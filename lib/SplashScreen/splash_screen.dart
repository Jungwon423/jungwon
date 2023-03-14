import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static const storage =
      FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () async {
      String? oAuthToken = await storage.read(key: "OAuthToken");
      print(oAuthToken);

      if (oAuthToken == null) {
        Navigator.pushReplacementNamed(context, '/login');
      }
      else
        Navigator.pushReplacementNamed(context, '/chat');


      // Navigator.pushReplacementNamed(context, "/chat");
    });
    return Scaffold(
        body: Center(
      child: Image.asset('assets/images/아이콘 최종 핑크2_배경없음.png',
          width: MediaQuery.of(context).size.width * 0.6, fit: BoxFit.contain),
    ));
  }
}
