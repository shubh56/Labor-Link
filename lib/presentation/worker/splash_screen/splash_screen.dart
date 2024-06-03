import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:laborlink/presentation/worker/home_container_screen/home_container_screen.dart';
import 'package:laborlink/presentation/worker/onboarding_one_screen/onboarding_one_screen.dart';
import 'package:laborlink/theme/theme_helper.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<bool> isUserLoggedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: Duration(seconds: 20))
        ..repeat();

  @override
  void initState() {
    Timer(const Duration(seconds: 8), () {
      // After 3 seconds, check authentication status and navigate to the appropriate screen
      isUserLoggedIn().then((loggedIn) {
        _controller.dispose();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => OnboardingOneScreen(),
            // loggedIn ? HomeContainerScreen() : OnboardingOneScreen(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkPurple,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: Image.asset(
                'assets/images/SplashLogoCropped.png',
                height: Get.height * 0.1,
                width: Get.width * 0.3,
              ),
            ),
            SizedBox(
              height: Get.height * 0.02,
              width: Get.height * 0.4,
            ),
            AnimatedTextKit(
              isRepeatingAnimation: true,
              totalRepeatCount: 5,
              animatedTexts: [
                TypewriterAnimatedText(
                  'Labor Link',
                  textStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: Get.height * 0.03,
                    color: Colors.white,
                  ),
                  speed: const Duration(milliseconds: 200),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
