import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:eyot/feature/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSplashScreen(
        backgroundColor: Color(0xFF2F2E2E),
        nextScreen: _validatedScreen(),
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/VolksWagenLogo.jpg",
              width: 800,
            ),
            SizedBox(height: 5),
            Text(
              "E Y O T",
              style: GoogleFonts.kayPhoDu(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.normal),
            )
          ],
        ),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 800,
      ),
    );
  }

  Widget _validatedScreen() {
    return LoginPage();
  }
}
