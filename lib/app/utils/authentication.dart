import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  static String _tokenKey = "token";
  static String _refreshTokenKey = "refreshToken";
  static String _rememberMeKey = "rememberMe";
  static String bonitaWebsite = "https://bonita.community";
  static String contactEmail = "contact@bonita.community";
  static String supportEmail = "support@bonita.community";

  static Future<bool> authenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) != null;
  }

  static void logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_tokenKey);
    setRememberMe(false);
  }

  static void setRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_rememberMeKey, value);
  }

  static Future<bool?> getRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_rememberMeKey);
  }

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_tokenKey, token);
  }

  static void saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_refreshTokenKey, refreshToken);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }
}
