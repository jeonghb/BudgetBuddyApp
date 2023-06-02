import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Bill with ChangeNotifier {
  TextEditingController requestId = TextEditingController();
  TextEditingController registDatetime = TextEditingController();
  TextEditingController requestAmount = TextEditingController();
  TextEditingController fileName = TextEditingController();
  TextEditingController paymentDatetime = TextEditingController();
  TextEditingController memo = TextEditingController();
  String approvalRequestDepartmentId = '';
  String approvalRequestDepartmentName = '';
  List<XFile> fileList = [];
  TextEditingController approvalType = TextEditingController();
  TextEditingController approvalDatetime = TextEditingController();
  TextEditingController calculateStatus = TextEditingController();
  TextEditingController calculateDatetime = TextEditingController();

  Future<bool> save() async {
    Uri uri = Uri.parse('http://211.197.27.23:8081/requestBill');

    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'requestUserId': 'goddnsl',
        'requestAmount': requestAmount.text,
        'paymentDatetime': paymentDatetime.text.substring(0, 16), 
        'memo': memo.text, 
        'approvalRequestDepartmentId': approvalRequestDepartmentId, 
        'fileList': fileList,
        })
    );

    if (response.statusCode == 200) {
      if (response.body == 1) {
        return true;
      }
      else return false;
    }
    else {
      return false;
    }
  }
}