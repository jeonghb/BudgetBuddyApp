import 'package:flutter/material.dart';
import '../app_core.dart';
import 'position.dart';
import 'response_data.dart';

class Department with ChangeNotifier {
  int departmentId = -1;
  String departmentName = '';
  bool activationStatus = true;
  List<Position> positionList = <Position>[];

  void setData(var json) {
    departmentId = AppCore.getJsonInt(json, 'departmentId');
    departmentName = AppCore.getJsonString(json, 'departmentName');
    activationStatus = AppCore.getJsonBool(json, 'departmentActivationStatus');
  }

  Future<bool> departmentUpdate() async {
    String address = '/departmentUpdate';
    Map<String, dynamic> body = {
      'departmentId': departmentId,
      'departmentName': departmentName,
      'departmentActivationStatus': activationStatus,
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