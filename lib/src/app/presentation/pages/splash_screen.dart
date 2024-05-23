import 'package:flutter/material.dart';
import 'package:tiktok_tdd/core/utils/constants/images.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Image(
          image: AssetImage(TImages.logo),
          height: 150,
        ),
      ),
    );
  }
}
