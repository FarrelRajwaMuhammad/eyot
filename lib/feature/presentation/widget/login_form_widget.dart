import 'package:eyot/core/material/color_material.dart';
import 'package:eyot/feature/presentation/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginForm extends StatelessWidget {
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        width: 400,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              'Sign In',
              style: GoogleFonts.kayPhoDu(
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (val) => loginController.email.value = val,
              decoration: InputDecoration(
                labelText: 'email',
                labelStyle: GoogleFonts.kayPhoDu(),
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (val) => loginController.password.value = val,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'password',
                labelStyle: GoogleFonts.kayPhoDu(),
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 60),
            Obx(() => SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87),
                    onPressed: loginController.isLoading.value
                        ? null
                        : loginController.login,
                    child: loginController.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Login',
                            style: GoogleFonts.kayPhoDu(
                                fontSize: 24, color: whiteColor)),
                  ),
                )),
            SizedBox(height: 20),
            Row(
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
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
