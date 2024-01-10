// ignore_for_file: constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'models/response_data.dart';
import 'models/user.dart';

class AppCore extends ChangeNotifier {
  static String baseUrl = "http://218.146.68.250:8081";
  static String localUrl = "http://192.168.0.2:8081";
  static AppCore instance = AppCore();
  static User user = User();
  static bool isLoading = false;

  void setUser(User newUser) {
    user = newUser;
  }

  User getUser() {
    return user;
  }

  Future<User> getUserDB() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.getBool('autoLogin') != null && preferences.getBool('autoLogin')!) {
      User localUserInfo = User();
      localUserInfo.userId = preferences.getString('userId')!;
      localUserInfo.userPassword = preferences.getString('userPassword')!;

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

  static Future<ResponseData> request(ServerType serverType, String address, dynamic body, List<XFile>? fileList) async {
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
          ).timeout(const Duration(seconds: 3));
        break;
        case ServerType.GET:
          Future.delayed(Duration(seconds: 1));
          response = await http.get(
            uri,
            headers: {"Content-Type": "application/json"},
          ).timeout(const Duration(seconds: 3));
        break;
        case ServerType.FILE:
          http.MultipartRequest request = http.MultipartRequest(
            'POST',
            uri,
          );

          request.fields.addAll(body);

          for (XFile file in fileList!) {
            request.files.add(await http.MultipartFile.fromPath('fileList', file.path));
          }

          response = await http.Response.fromStream(await request.send()).timeout(const Duration(seconds: 10));
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
    instance.notifyListeners();
  }

  static void finishServerRequest() {
    isLoading = false;
    instance.notifyListeners();
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
          // title: Column(children: <Widget>[Text(title)]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: newWidgets,
          ),
          actions: actionType == ActionType.ok ? <Widget>[
            TextButton(
              onPressed: functionOnPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 90, 68, 223)),
                overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
              ),
              child: Text(
                '확인',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ] : <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.red),
                overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
              ),
              child: Text(
                '취소',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            TextButton(
              onPressed: functionOnPressed,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 90, 68, 223)),
                overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
              ),
              child: Text(
                '확인',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
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

    ResponseData responseData = await AppCore.request(ServerType.GET, address, body, null);

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

  static bool getJsonBoolDefaultTrue(var json, String name) {
    String returnValue = json[name]?.toString() ?? 'true';
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
    return user.selectGroup.getAuthList().any((element) => element.authName == authName);
  }
}

enum ActionType {
  ok,
  yesNo,
}

enum ServerType {
  GET,
  POST,
  FILE,
}