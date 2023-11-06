import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/app_core.dart';
import 'package:test/models/response_data.dart';

class Receipt with ChangeNotifier {
  int requestId = -1;
  String requestUserId = '';
  String requestUserName = '';
  String registDatetime = DateTime.now().toString();
  String title = '';
  int requestAmount = -1;
  String paymentDatetime = DateTime.now().toString();
  String memo = '';
  int approvalRequestDepartmentId = -1;
  String approvalRequestDepartmentName = '';
  int budgetTypeId = -1;
  String budgetTypeName = '';
  List<XFile> fileList = [];
  String bankName = '';
  String bankAccountNumber = '';
  int submissionStatus = 0;
  String rejectMessage = '';
  int approvalType = -1;
  String approvalDatetime = DateTime.now().toString();
  int calculateStatus = -1;
  String calculateDatetime = DateTime.now().toString();

  void setData(Map<String, dynamic> json) {
    requestId = AppCore.getJsonInt(json, 'requestId');
    requestUserId = AppCore.getJsonString(json, 'requestUserId');
    requestUserName = AppCore.getJsonString(json, 'requestUserName');
    registDatetime= AppCore.getJsonString(json, 'registDatetime');
    title = AppCore.getJsonString(json, 'title');
    requestAmount = AppCore.getJsonInt(json, 'requestAmount');
    paymentDatetime = AppCore.getJsonString(json, 'paymentDatetime');
    memo = AppCore.getJsonString(json, 'memo');
    approvalRequestDepartmentId = AppCore.getJsonInt(json, 'approvalRequestDepartmentId');
    approvalRequestDepartmentName = AppCore.getJsonString(json, 'approvalRequestDepartmentName');
    budgetTypeId = AppCore.getJsonInt(json, 'budgetTypeId');
    budgetTypeName = AppCore.getJsonString(json, 'budgetTypeName');
    // fileList = json['fileList'].map((fileJson) { return XFile(fileJson['path']); }).toList();
    bankName = AppCore.getJsonString(json, 'bankName');
    bankAccountNumber = AppCore.getJsonString(json, 'bankAccountNumber');
    submissionStatus = AppCore.getJsonInt(json, 'submissionStatus');
    approvalType = AppCore.getJsonInt(json, 'approvalType');
    approvalDatetime = AppCore.getJsonString(json, 'approvalDatetime');
    rejectMessage = AppCore.getJsonString(json, 'rejectMessage');
    calculateStatus = AppCore.getJsonInt(json, 'calculateStatus');
    calculateDatetime = AppCore.getJsonString(json, 'calculateDatetime');
  }

  Future<bool> requestReceipt() async {
    String address = '/requestReceipt';
    Map<String, dynamic> body = {
      'requestId': requestId,
      'requestUserId': AppCore.instance.getUser().userId,
      'title': title,
      'requestAmount': requestAmount,
      'paymentDatetime': paymentDatetime,
      'memo': memo,
      'approvalRequestDepartmentId': approvalRequestDepartmentId,
      'budgetTypeId': budgetTypeId,
      'fileList': fileList,
      'bankName' : bankName,
      'bankAccountNumber': bankAccountNumber,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      if (responseData.body == 'true') {
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  Future<bool> changeSubmissionStatus() async {
    String address = '/changeSubmissionStatus';
    Map<String, dynamic> body = {
      'requestId': requestId,
      'submissionStatus': submissionStatus,
      'rejectMessage': rejectMessage,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      if (responseData.body == 'true') {
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }
}