import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/app_core.dart';
import 'package:test/models/response_data.dart';

class Receipt with ChangeNotifier {
  TextEditingController requestId = TextEditingController();
  TextEditingController registDatetime = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController requestAmount = TextEditingController();

  String paymentDatetime = DateTime.now().toString();
  TextEditingController paymentDatetimeYear = TextEditingController();
  TextEditingController paymentDatetimeMonth = TextEditingController();
  TextEditingController paymentDatetimeDay = TextEditingController();
  TextEditingController paymentDatetimeHour = TextEditingController();
  TextEditingController paymentDatetimeMinute = TextEditingController();

  TextEditingController memo = TextEditingController();

  String approvalRequestDepartmentId = '-1';
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
    String address = '/requestReceipt';
    Map<String, dynamic> body = {
      'requestId': requestId.text,
      'requestUserId': 'goddnsl',
      'title': title.text,
      'requestAmount': requestAmount.text,
      'paymentDatetime': getPaymentDatetime(), 
      'memo': memo.text, 
      'approvalRequestDepartmentId': approvalRequestDepartmentId, 
      'fileList': fileList,
      'accountNumber': AccountNumber,
    };

    ResponseData responseData = await AppCore.request(address, body);

    if (responseData.statusCode == 200) {
      if (responseData.body == '1') {
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

  void fromJson(Map<String, dynamic> json) {
    requestId.text = json['requestId'].toString();
    registDatetime.text = json['registDatatime'].toString();
    title.text = json['title'].toString();
    requestAmount.text = json['requestAmount'].toString();
    paymentDatetime = json['paymentDatetime'].toString();
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
    String address = '/changeSubmissionStatus';
    Map<String, dynamic> body = {
      'requestId': requestId.text,
      'submissionStatus': submissionStatus,
      'rejectMessage': rejectMessage.text,
    };

    ResponseData responseData = await AppCore.request(address, body);

    if (responseData.statusCode == 200) {
      if (responseData.body == '1') {
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

  getPaymentDatetime() {
    if (paymentDatetimeYear.text.isNotEmpty
     || paymentDatetimeMonth.text.isNotEmpty
     || paymentDatetimeDay.text.isNotEmpty
     || paymentDatetimeHour.text.isNotEmpty
     || paymentDatetimeMinute.text.isNotEmpty) {
      paymentDatetime = '${paymentDatetimeYear.text.padLeft(4, '0')}-${paymentDatetimeMonth.text.padLeft(2, '0')}-${paymentDatetimeDay.text.padLeft(2, '0')} ${paymentDatetimeHour.text.padLeft(2, '0')}:${paymentDatetimeMinute.text.padLeft(2, '0')}';
    }
  }

  setPaymentDatetime() {
      paymentDatetimeYear.text = paymentDatetime.substring(0, 4);
      paymentDatetimeMonth.text = paymentDatetime.substring(4, 2);
      paymentDatetimeDay.text = paymentDatetime.substring(6, 2);
      paymentDatetimeHour.text = paymentDatetime.substring(9, 2);
      paymentDatetimeMinute.text = paymentDatetime.substring(12, 2);
  }
}