import 'package:test/app_core.dart';

class Bank {
  int bankId = -1;
  String bankName = '';
  int activationStatus = -1;

  void setData(var json) {
    bankId = AppCore.getJsonInt(json, 'bankId');
    bankName = AppCore.getJsonString(json, 'bankName');
    activationStatus = AppCore.getJsonInt(json, 'bankActivationStatus');
  }
}