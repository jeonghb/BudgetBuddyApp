import 'package:test/app_core.dart';

import 'auth.dart';
import 'response_data.dart';

class Position {
  int departmentId = -1;
  String departmentName = '';
  bool departmentActivationStatus = false;
  int positionId = -1;
  String positionName = '';
  List<Auth> positionAuthList = [];
  bool positionActivationStatus = false;

  void setData(var json) {
    departmentId = AppCore.getJsonInt(json, 'departmentId');
    departmentName = AppCore.getJsonString(json, 'departmentName');
    departmentActivationStatus = AppCore.getJsonBool(json, 'departmentActivationStatus');
    positionId = AppCore.getJsonInt(json, 'positionId');
    positionName = AppCore.getJsonString(json, 'positionName');
    if (json['positionAuthList'] != null) {
      for (var jsonAuth in json['positionAuthList'])
      {
        Auth auth = Auth();
        auth.setData(jsonAuth);
        positionAuthList.add(auth);
      }
    }
    positionActivationStatus = AppCore.getJsonBool(json, 'positionActivationStatus');
  }

  Future<bool> positionUpdate() async {
    String address = '/positionUpdate';
    Map<String, dynamic> body = {
      'positionId': positionId,
      'positionName': positionName,
      'positionAuthList': positionAuthList.map((e) => {
        'positionId': positionId,
        'authId' : e.authId,
        'authName': e.authName,
        'use': e.use,
      }).toList(),
      'positionActivationStatus': positionActivationStatus,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

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