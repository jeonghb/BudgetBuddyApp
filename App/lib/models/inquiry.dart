import 'package:test/app_core.dart';

class Inquiry {
  String inquiryUserId = '';
  String inquiryUserName = '';
  String inquiryTitle = '';
  String inquiryMemo = '';
  String inquiryDatetime = '';
  String inquiryAnswer = '';

  void setData(var json) {
    inquiryUserId = AppCore.getJsonString(json, 'inquiryUserId');
    inquiryUserName = AppCore.getJsonString(json, 'inquiryUserName');
    inquiryTitle = AppCore.getJsonString(json, 'inquiryTitle');
    inquiryMemo = AppCore.getJsonString(json, 'inquiryMemo');
    inquiryDatetime = AppCore.getJsonString(json, 'inquiryDatetime');
    inquiryAnswer = AppCore.getJsonString(json, 'inquiryAnswer');
  }
}