import 'dart:convert';

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

  Future<void> Regist() async {
    Uri uri = Uri.parse('localhost:8080');

    var response = await http.post(
      uri,
      body: {'id': id.text, 'pw': pw.text, 'name': name.text, 'email': email.text, 'phoneNumber': phoneNumber.text, 'birthDay': birthDay.text, 'sex': sex.text}
    );
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    print(await http.read(Uri.https('localhost:8081', 'test.txt')));
  }
}