import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:frontend_project/main.dart';
import 'package:frontend_project/utils/app_style.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Lottie.asset("assets/SplashScreen.json"),
      splashIconSize: 235,
      nextScreen: const Root(),
      pageTransitionType: PageTransitionType.fade,
      animationDuration: const Duration(milliseconds: 700),
      backgroundColor: Styles.bgColor,
    );
  }
}
