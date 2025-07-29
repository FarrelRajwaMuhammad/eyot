import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _SplashLoginTransitionState();
}

class _SplashLoginTransitionState extends State<LoginPage> { 
  bool showLogin = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        showLogin = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      body: Stack(
        children: [
          // Tulisan EYOT
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: const EdgeInsets.only(top: 80),
              child: Text(
                "E Y O T",
                style: GoogleFonts.kayPhoDu(
                  fontSize: 48,
                  color: Colors.white,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),

          // Box Login (Animated)
          AnimatedPositioned(
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOut,
            bottom: showLogin ? 0 : -500,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Color(0xFFE0E0E0),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Sign In",
                    style: GoogleFonts.kayPhoDu(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: UnderlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onPressed: () {},
                      child: const Text("Login"),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("don't have an account? "),
                      GestureDetector(
                        onTap: () {},
                        child: const Text(
                          "sign up",
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
