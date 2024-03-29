import 'package:test/app_core.dart';

import 'response_data.dart';

class BudgetType{
  int departmentId = -1;
  String departmentName = '';
  int budgetTypeId = -1;
  String budgetTypeName = '';
  bool activationStatus = false;

  void setData(var json) {
    departmentId = AppCore.getJsonInt(json, 'departmentId');
    departmentName = AppCore.getJsonString(json, 'departmentName');
    budgetTypeId = AppCore.getJsonInt(json, 'budgetTypeId');
    budgetTypeName = AppCore.getJsonString(json, 'budgetTypeName');
    activationStatus = AppCore.getJsonBool(json, 'activationStatus');
  }

  Future<bool> budgetTypeAdd() async {
    String address = '/budgetTypeAdd';
    Map<String, dynamic> body = {
      'departmentId' : departmentId,
      'budgetTypeName': budgetTypeName,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      if (responseData.body.toString() == 'true') {
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

  Future<bool> budgetTypeActivationStatusSave(bool status) async {
    String address = '/budgetTypeActivationStatusSave';
    Map<String, dynamic> body = {
      'departmentId': departmentId,
      'budgetTypeId': budgetTypeId,
      'activationStatus': status,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      if (responseData.body.toString() == 'true') {
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