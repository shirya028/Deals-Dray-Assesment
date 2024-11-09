import 'dart:convert';

import 'package:deals_dray/controller.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'error_screen.dart';
import 'login_page.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



Controller controller = Controller();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      controller.postData(context);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/splash_img.jpg',
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
