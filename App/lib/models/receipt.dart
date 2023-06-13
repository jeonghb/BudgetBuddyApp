import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Receipt with ChangeNotifier {
  TextEditingController requestId = TextEditingController();
  TextEditingController registDatetime = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController requestAmount = TextEditingController();
  TextEditingController paymentDatetime = TextEditingController();
  TextEditingController memo = TextEditingController();
  String approvalRequestDepartmentId = '';
  String approvalRequestDepartmentName = '';
  List<XFile> fileList = [];
  TextEditingController AccountNumber = TextEditingController();
  int submissionStatus = 0;
  TextEditingController rejectMessage = TextEditingController();
  TextEditingController approvalType = TextEditingController();
  TextEditingController approvalDatetime = TextEditingController();
  TextEditingController calculateStatus = TextEditingController();
  TextEditingController calculateDatetime = TextEditingController();

  Future<bool> save() async {
    Uri uri = Uri.parse('http://211.197.27.23:8081/requestReceipt');

    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'requestId': requestId.text,
        'requestUserId': 'goddnsl',
        'title': title.text,
        'requestAmount': requestAmount.text,
        'paymentDatetime': paymentDatetime.text.substring(0, 16), 
        'memo': memo.text, 
        'approvalRequestDepartmentId': approvalRequestDepartmentId, 
        'fileList': fileList,
        'accountNumber': AccountNumber,
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

  void FromJson(Map<String, dynamic> json) {
    requestId.text = json['requestId'].toString();
    registDatetime.text = json['registDatatime'].toString();
    title.text = json['title'].toString();
    requestAmount.text = json['requestAmount'].toString();
    paymentDatetime.text = json['paymentDatetime'].toString();
    memo.text = json['memo'].toString();
    approvalRequestDepartmentId = json['approvalRequestDepartmentId'].toString();
    approvalRequestDepartmentName = json['approvalRequestDepartmentName'].toString();
    // fileList = json['fileList'].map((fileJson) { return XFile(fileJson['path']); }).toList();
    AccountNumber.text = json['accountNumber'].toString();
    approvalType.text = json['approvalType'].toString();
    approvalDatetime.text = json['approvalDatetime'].toString();
    calculateStatus.text = json['calculateStatus'].toString();
    calculateDatetime.text = json['calculateDatetime'].toString();
  }

  Future<bool> changeSubmissionStatus() async {
    Uri uri = Uri.parse('http://211.197.27.23:8081/changeSubmissionStatus');

    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'requestId': requestId.text,
        'submissionStatus': submissionStatus,
        'rejectMessage': rejectMessage.text,
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