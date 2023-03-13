import 'package:flutter/material.dart';
import 'package:jungwon/ChatScreen/chat_page.dart';
import 'package:jungwon/LoginScreen/login.dart';

import 'SplashScreen/splash_screen.dart';

final Map<String, WidgetBuilder> route = {
  "/splash": (context) => const SplashScreen(),
  "/login": (context) => const LoginScreen(),

  "/chat": (context) => const ChatScreen(),
};