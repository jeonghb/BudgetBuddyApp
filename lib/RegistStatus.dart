import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegistStatus {
  TextEditingController id = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController birthDay = TextEditingController();
  TextEditingController sex = TextEditingController();

  Future<bool> Regist() async {
    Uri uri = Uri.parse('http://192.168.0.2:8081/userRegist');
    // Uri uri = Uri.parse('http://61.82.156.112:6112/userRegist');

    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({'id': id.text, 'pw': pw.text, 'name': name.text, 'email': email.text, 'phoneNumber': phoneNumber.text, 'birthDay': birthDay.text, 'sex': sex.text})
    );
    
    print(response.body);

    // print(await http.read(Uri.http('localhost:8085/userRegist')));

    return true;
  }
}