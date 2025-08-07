import 'package:eyot/core/material/color_material.dart';
import 'package:eyot/feature/presentation/widget/login_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  Text(
                    "E Y O T",
                    style: GoogleFonts.kayPhoDu(
                        fontSize: 48,
                        color: blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Elevate Your Opportunities Today",
                    style: GoogleFonts.kayPhoDu(
                        fontSize: 16,
                        color: blackColor,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(height: 40),
                  Expanded(
                    child: LoginForm(),
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
