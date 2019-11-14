import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  int userId;
  Future<void> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData'));
    userId = extractedUserData['userId'];
    return userId;
  }
}
