import 'package:test/app_core.dart';

class Auth {
  int positionId = -1;
  String authId = '';
  String authName = '';
  bool use = false;

  void setData(var json) {
    positionId = AppCore.getJsonInt(json, 'positionId');
    authId = AppCore.getJsonString(json, 'authId');
    authName = AppCore.getJsonString(json, 'authName');
    use = AppCore.getJsonBool(json, 'use');
  }
}