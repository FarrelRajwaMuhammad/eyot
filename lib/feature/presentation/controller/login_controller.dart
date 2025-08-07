import 'package:eyot/feature/presentation/pages/home_page.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoginController extends GetxController {
  final email = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;

  final SupabaseClient supabase = Supabase.instance.client;

  Future<void> login() async {
    isLoading.value = true;

    try {
      final response = await supabase.auth.signInWithPassword(
        email: email.value,
        password: password.value,
      );

      if (response.user != null) {
        Get.snackbar("Success", "Login successful");
        Get.offAll(() => HomePage());
      } else {
        Get.snackbar("Error", "Login failed");
      }
    } catch (e) {
      Get.snackbar("Login Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
