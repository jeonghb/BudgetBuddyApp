import 'dart:convert';
import 'dart:ffi';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class RegistStatus with ChangeNotifier {
  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController birthDay = TextEditingController();
  TextEditingController sex = TextEditingController();
  
  static RegExp idRegExp = RegExp(r'[\W]|[\\\[\]\^\`]');
  static RegExp pwRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[$@$!%*?&])[A-Za-z\d$@$!%*?&]{8,}');
  static RegExp nameRegExp = RegExp(r'[가-힣]');
  static RegExp emailRegExp = RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9.!#$%&*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
  static RegExp phoneNumberRegExp = RegExp(r'^010-?([0-9]{4})-?([0-9]{4})$');

  RegistStatus() {
    birthDay.text = DateTime.now().toString().substring(0, 10);
    sex.text = 'male';
  }

  Future<String> Regist() async {
    Uri uri = Uri.parse('http://192.168.0.2:8081/userRegist');
    // Uri uri = Uri.parse('http://61.82.156.112:6112/userRegist');

    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({'id': id.text, 'pw': sha512.convert(utf8.encode(pw.text)).toString(), 'name': name.text, 'email': email.text, 'phoneNumber': phoneNumber.text, 'birthDay': birthDay.text, 'sex': sex.text})
    );
    
    print(response.body);

    // print(await http.read(Uri.http('localhost:8085/userRegist')));

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
}