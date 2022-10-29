import 'dart:async';

import 'package:att_system_app/constants/theme.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void splashScreenStart() async {
    var duration = const Duration(seconds: 3);
    Timer(duration, () {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    });
  }

  @override
  void initState() {
    splashScreenStart();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logos-timer.png'),
                ),
              ),
            ),
            Text(
              'Attendance APP',
              style: navyTextSytle.copyWith(fontSize: 24, fontWeight: bold),
            )
          ],
        ),
      ),
    );
  }
}
