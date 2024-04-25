import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shopedia/features/home_screen.dart';
import 'package:shopedia/features/test_screen.dart';
import 'package:shopedia/features/utils/loading_screen.dart';
import 'package:shopedia/features/utils/message_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    startHomeScreen();
  }

  startHomeScreen() async {
    var duration = const Duration(seconds: 1);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return HomeScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          "assets/icons/ic_icon.png",
          height: 150,
          width: 150,
        ),
      )),
    );
  }
}
