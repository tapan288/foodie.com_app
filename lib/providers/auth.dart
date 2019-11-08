import 'dart:convert';

import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  int _userId;
  DateTime _expiryDate;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    if (_expiryDate != null && _token != null) {
      return _token;
    }
    return null;
  }

  int get userId {
    return _userId;
  }

  void logout() async {
    _userId = null;
    _token = null;
    _expiryDate = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

  Future<void> signup(String name, String email, String password) async {
    const url = 'http://10.0.2.2/foodie.com/public/api/register';
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'name': name,
            'email': email,
            'password': password,
          },
        ),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      final responseData = json.decode(response.body);
      if (responseData['message'] != null) {
        throw HttpException(responseData['message']);
      }
      if (responseData['success']) {
        _token = responseData['token'];
        _userId = responseData['user_id'];
      }
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    const url = 'http://10.0.2.2/foodie.com/public/api/login';

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'email': email,
            'password': password,
          },
        ),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
      );
      final responseData = json.decode(response.body);
      // print(responseData);

      if (responseData['error'] != null) {
        throw HttpException(responseData['error']);
      }

      _token = responseData['token'];
      _userId = responseData['user_id'];
      notifyListeners();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
      });
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData'));
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    notifyListeners();
    return true;
  }
}
