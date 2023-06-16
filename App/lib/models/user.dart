import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/app_core.dart';

class User with ChangeNotifier {
  TextEditingController userId = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  TextEditingController userName = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhoneNumber = TextEditingController();
  TextEditingController userBirthday = TextEditingController();
  TextEditingController userSex = TextEditingController();
  int departmentId = -1;
  // Image? image;
  bool isLoginSucess = false;
  
  static RegExp idRegExp = RegExp(r'[\W]|[\\\[\]\^\`]');
  static RegExp pwRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}');
  static RegExp nameRegExp = RegExp(r'[가-힣]');
  static RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  static RegExp phoneNumberRegExp = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');

  RegistStatus() {
    userBirthday.text = DateTime.now().toString();
    userSex.text = 'male';
  }

  int getDepartmentId() {
    return departmentId;
  }

  Future<String> Check() async {
    // Uri uri = Uri.parse('http://192.168.0.2:8081/userCheck');
    Uri uri = Uri.parse('http://211.197.27.23:8081/userCheck');

    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({'id': userId.text, 'pw': sha512.convert(utf8.encode(userPassword.text)).toString(), 'name': userName.text, 'email': userEmail.text, 'phoneNumber': userPhoneNumber.text, 'birthDay': userBirthday.text, 'sex': userSex.text})
    );
    
    print(response.body);

    return response.body;
  }

  Future<String> Regist() async {
    // Uri uri = Uri.parse('http://192.168.0.2:8081/userRegist');
    Uri uri = Uri.parse('http://211.197.27.23:8081/userRegist');

    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({'id': userId.text, 'pw': sha512.convert(utf8.encode(userPassword.text)).toString(), 'name': userName.text, 'email': userEmail.text, 'phoneNumber': userPhoneNumber.text, 'birthDay': userBirthday.text, 'sex': userSex.text})
    );
    
    print(response.body);

    return response.body;
  }

  String idCheck(String? value) {
    return value == null || value.length < 5 || idRegExp.hasMatch(value) ? '5자 이상이어야 하며, 특수문자는 _만 사용 가능합니다.' : '';
  }

  String pwCheck(String? value) {
    return value == null || !pwRegExp.hasMatch(value) ? '알파벳 대문자, 소문자, 숫자, 특수문자를 반드시 포함하여 8자 이상 입력하세요.' : '';
  }

  String pwEqualCheck(String? value, String pwCheck) {
    return pwCheck == '' ? '비밀번호를 입력해주세요.' : (value == null ? '' : value.toString()) != pwCheck ? '입력한 비밀번호와 일치하지 않습니다.' : '';
  }

   String nameCheck(String? value) {
    return value == null || value.length < 2 || !nameRegExp.hasMatch(value) ? '정상적인 이름 형식이 아닙니다.' : '';
  }

   String emailCheck(String? value) {
    return value == null || !emailRegExp.hasMatch(value) ? '정상적인 이메일 형식이 아닙니다.' : '';
  }

   String phoneNumberCheck(String? value) {
    return value == null || !phoneNumberRegExp.hasMatch(value) ? '정상적인 휴대폰번호 형식이 아닙니다.' : '';
  }

  Future<String> login(bool isPasswordEncode) async {
    //Uri uri = Uri.parse(AppCore.localUrl + '/LogIn');
    Uri uri = Uri.parse(AppCore.baseUrl + '/LogIn');

    try {
      http.Response response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: json.encode({'id': userId.text, 'pw': isPasswordEncode ? sha512.convert(utf8.encode(userPassword.text)).toString() : userPassword.text })
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200)
      {
        if (json.decode(response.body)['logInIsSuccess']) {
          userName.text = json.decode(response.body)['name'];
          userEmail.text = json.decode(response.body)['email'];
          userPhoneNumber.text = json.decode(response.body)['phoneNumber'];
          userBirthday.text = json.decode(response.body)['birthDay'];
          userSex.text = json.decode(response.body)['sex'];
          isLoginSucess = true;

          return '0';
        }
        else {
          isLoginSucess = false;
          return '1';
        }
      }
      else {
        isLoginSucess = false;
        return '2';
      }
    }
    on TimeoutException {
      isLoginSucess = false;
      return '2';
    }
    catch (e) {
      isLoginSucess = false;
      return '2';
    }
  }
}