import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static late SharedPreferences instance;
  static const String isLogin = "isLogin";
  static const String uid = "uid";
  static const String isAdmin = "isAdmin";
  static const String image = "image";
  static const String firstName = "firstName";
  static const String lastName = "lastName";
  static const String email = "email";
  static const String mobile = "mobile";
}
