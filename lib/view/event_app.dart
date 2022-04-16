import 'package:evento_app/view/login_screen.dart';
import 'package:flutter/material.dart';

class EventApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Nosso evento",
      home: LoginScreen(),
    );
  }
}
