import 'package:eyot/core/material/color_material.dart';
import 'package:eyot/feature/presentation/controller/login_controller.dart';
import 'package:eyot/feature/presentation/widget/version_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginFormWidget extends StatelessWidget {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //email input
          Container(
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 4)),
                ]),
            child: TextField(
              onChanged: (val) => loginController.email.value = val,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: GoogleFonts.kayPhoDu(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: whiteColor,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          SizedBox(height: 40),
          Container(
            decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 4)),
                ]),
            child: TextField(
              onChanged: (val) => loginController.password.value = val,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: GoogleFonts.kayPhoDu(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                filled: true,
                fillColor: whiteColor,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
          SizedBox(height: 80),
          Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: gradientBG,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                    shadowColor: Colors.black.withOpacity(0.8),
                    elevation: 8,
                    padding: EdgeInsets.symmetric(vertical: 6),
                  ),
                  onPressed: loginController.isLoading.value
                      ? null
                      : loginController.login,
                  child: loginController.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Login',
                          style: GoogleFonts.kayPhoDu(
                              fontSize: 24,
                              color: whiteColor,
                              fontWeight: FontWeight.bold),
                        ),
                ),
              )),
          SizedBox(height: 20),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "don't have an account?",
                  style: GoogleFonts.kayPhoDu(
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "Sign Up",
                    style:
                        GoogleFonts.kayPhoDu(fontSize: 12, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 80),
        ],
      ),
    );
  }
}
