import 'package:test/app_core.dart';

import 'response_data.dart';

class Budget {
  int id = -1;
  int departmentId = -1;
  String departmentName = '';
  int budgetTypeId = -1;
  String budgetTypeName = '';
  String budgetTitle = '';
  String budgetMemo = '';
  String budgetDate = DateTime.now().toString().substring(0, 6);
  int budgetAmount = -1;

  void setData(var json) {
    id = AppCore.getJsonInt(json, 'id');
    departmentId = AppCore.getJsonInt(json, 'departmentId');
    departmentName = AppCore.getJsonString(json, 'departmentName');
    budgetTypeId = AppCore.getJsonInt(json, 'budgetTypeId');
    budgetTypeName = AppCore.getJsonString(json, 'budgetTypeName');
    budgetTitle = AppCore.getJsonString(json, 'budgetTitle');
    budgetMemo = AppCore.getJsonString(json, 'budgetMemo');
    budgetDate = AppCore.getJsonString(json, 'budgetDate');
    budgetAmount = AppCore.getJsonInt(json, 'budgetAmount');
  }

  Future<bool> budgetUpdate() async {
    String address = '/budgetUpdate';
    Map<String, dynamic> body = {
      'id': id,
      'departmentId': departmentId,
      'budgetTypeId': budgetTypeId,
      'budgetTitle': budgetTitle,
      'budgetMemo': budgetMemo,
      'budgetAmount': budgetAmount,
      'budgetDate': budgetDate,
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

  Future<bool> budgetDelete() async {
    String address = '/budgetDelete';
    Map<String, dynamic> body = {
      'id': id,
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