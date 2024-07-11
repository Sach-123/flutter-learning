import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_meter/screens/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Home()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                Color(0xFF5B7C88),
                Color(0xFF1A4254),
              ])),
          child: const Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "WEATHER",
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF021C23),
                    fontWeight: FontWeight.w800),
              ),
              Icon(
                Icons.flash_on,
                color: Colors.white,
                size: 42,
              ),
              Text(
                "METER",
                style: TextStyle(
                    fontSize: 30,
                    color: Color(0xFF021C23),
                    fontWeight: FontWeight.w800),
              ),
            ],
          ))),
    );
  }
}
