import 'dart:async';
import 'package:eka_lyrics/constants/colors.dart';
import 'package:eka_lyrics/constants/image_strings.dart';
import 'package:eka_lyrics/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(
          seconds: 2,
        ), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavBar(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            color: ekaPrimaryColor,
            image: DecorationImage(
              image: AssetImage(
                ekaLogoNB,
              ),
            )),
      ),
    );
  }
}
