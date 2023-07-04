import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'models/response_data.dart';
import 'models/user.dart';

class AppCore extends ChangeNotifier {
  static String baseUrl = "http://211.197.27.23:8081";
  static String localUrl = "http://192.168.0.2:8081";
  static AppCore instance = AppCore();
  static User user = User();
  static bool isLoading = false;

  void setUser(User _user) {
    user = _user;
  }

  User getUser() {
    return user;
  }

  Future<User> getUserDB() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('autoLogin') != null && preferences.getBool('autoLogin')!) {
      User localUserInfo = User();
      localUserInfo.userId.text = preferences.getString('userId')!;
      localUserInfo.userPassword.text = preferences.getString('userPassword')!;

      String result = await localUserInfo.userLogin(false);
      if (result == "0") {
        setUser(localUserInfo);
      }
    }

    return getUser();
  }

  Future<void> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setBool('autoLogin', false);
    preferences.setString('userId', '');
    preferences.setString('userPassword', '');

    User initializeUser = User();
    setUser(initializeUser);
  }

  static Future<ResponseData> request(String address, dynamic body) async {
    ResponseData responseData = ResponseData();

    try {
      Uri uri = Uri.parse(AppCore.baseUrl + address);

      loadingServerRequest();

      http.Response response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode(body),
      ).timeout(const Duration(seconds: 5));

      responseData.statusCode = response.statusCode;
      responseData.body = response.body;
    }
    catch (e) {
      if (e is TimeoutException) {
        responseData.errorMessage = 'Time Out';
      }
      else {
        responseData.errorMessage = e.toString();
      }
    }
    
    finishServerRequest();

    return responseData;
  }

  static void loadingServerRequest() {
    isLoading = true;
  }

  static void finishServerRequest() {
    isLoading = false;
  }
}