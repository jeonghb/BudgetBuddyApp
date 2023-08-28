// ignore_for_file: constant_identifier_names

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

  static Future<ResponseData> request(ServerType serverType, String address, dynamic body) async {
    ResponseData responseData = ResponseData();

    try {
      Uri uri = Uri.parse(AppCore.baseUrl + address);

      loadingServerRequest();

      http.Response response;

      switch (serverType)
      {
        case ServerType.POST:
          response = await http.post(
            uri,
            headers: {"Content-Type": "application/json"},
            body: json.encode(body),
          ).timeout(const Duration(seconds: 5));
        break;
        case ServerType.GET:
          response = await http.get(
            uri,
            headers: {"Content-Type": "application/json"},
          ).timeout(const Duration(seconds: 5));
        break;
      }

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

  static void showMessage(BuildContext context, String title, String message, ActionType actionType, Function() functionOnPressed, {List<Widget>? widgets}) {
    List<Widget> newWidgets = <Widget>[];
    
    newWidgets.add(Text(message));
    if (widgets != null) {
      newWidgets.addAll(widgets);
    }

    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Column(children: <Widget>[Text(title)]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: newWidgets,
          ),
          actions: actionType == ActionType.ok ? <Widget>[
            TextButton(
              onPressed: functionOnPressed,
              child: Text('확인'),
            ),
          ] : <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: Text('취소')
            ),
            TextButton(
              onPressed: functionOnPressed,
              child: Text('확인'),
            )
          ],
        );
      },
    );
  }

  static Future<List<String>> getBankList() async {
    List<String> bankList = <String>[];

    String address = '/getBankList';
    Map<String, dynamic> body = {
    };

    ResponseData responseData = await AppCore.request(ServerType.GET, address, body);

    if (responseData.statusCode == 200)
    {
      for (var json in jsonDecode(responseData.body))
      {
        bankList.add(json['bankName']);
      }
    }

    return bankList;
  }

  static String getJsonString(var json, String name) {
    return json[name]?.toString() ?? '';
  }

  static int getJsonInt(var json, String name) {
    String returnValue = json[name]?.toString() ?? '-1';
    return int.parse(returnValue);
  }

  static bool getJsonBool(var json, String name) {
    String returnValue = json[name]?.toString() ?? 'false';
    return returnValue == 'true' ? true : false;
  }

  static List<T> getJsonList<T>(var json, String name, T Function(dynamic) mapper) {
    final jsonArray = json[name] as List<dynamic>?;
    if (jsonArray == null) {
      return <T>[];
    }
    return jsonArray.map(mapper).toList();
  }

  static int parseInt(String value) {
    String returnValue = value.isEmpty ? '-1' : value;
    return int.parse(returnValue);
  }

  static bool authCheck(String authName) {
    return user.getAuthList().any((element) => element.authName == authName);
  }
}

enum ActionType {
  ok,
  yesNo,
}

enum ServerType {
  GET,
  POST,
}