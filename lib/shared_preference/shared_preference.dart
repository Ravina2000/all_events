import 'package:all_events_practical/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceController {
  static Future<void> storeUserInfo(String name, String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Store user information
    prefs.setString('user_name', name);
    prefs.setString('user_email', email);

    setBool("is_signed_in", true);
  }

  static Future<UserModel?> getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve user information
    final String? name = prefs.getString('user_name');
    final String? email = prefs.getString('user_email');

    if (name != null && email != null) {
      return UserModel(name: name, email: email);
    } else {
      return null;
    }
  }

  // Update sign-in status
  static setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }
}
