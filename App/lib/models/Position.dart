import 'package:test/app_core.dart';

class Position {
  int departmentId = -1;
  String departmentName = '';
  bool departmentActivationStatus = false;
  int positionId = -1;
  String positionName = '';
  int authFlag = 0;
  bool positionActivationStatus = false;

  void setData(var json) {
    departmentId = AppCore.getJsonInt(json, 'departmentId');
    departmentName = AppCore.getJsonString(json, 'departmentName');
    departmentActivationStatus = AppCore.getJsonBool(json, 'departmentActivationStatus');
    positionId = AppCore.getJsonInt(json, 'positionId');
    positionName = AppCore.getJsonString(json, 'positionName');
    authFlag = AppCore.getJsonInt(json, 'authFlag');
    positionActivationStatus = AppCore.getJsonBool(json, 'positionActivationStatus');
  }
}