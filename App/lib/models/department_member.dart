import '../app_core.dart';
import 'response_data.dart';

class DepartmentMember {
  String userId = '';
  String userName = '';
  String userBirthday = DateTime.now().toString();
  String userSex = 'male';
  String userSexName = '남';
  int userDepartmentId = -1;
  String userDepartmentName = '';
  int userPositionId = -1;
  String userPositionName = '';
  String userDepartmentRegistDatetime = DateTime.now().toString();

  void setData(Map<String, dynamic> json) {
    userId = AppCore.getJsonString(json, 'userId');
    userName = AppCore.getJsonString(json, 'userName');
    userBirthday = AppCore.getJsonString(json, 'userBirthday');
    userSex = AppCore.getJsonString(json, 'userSex');
    switch(userSex) {
      case 'male':
        userSexName = '남';
      break;
      case 'female':
        userSexName = '여';
      break;
    }
    userDepartmentId = AppCore.getJsonInt(json, 'userDepartmentId');
    userDepartmentName = AppCore.getJsonString(json, 'userDepartmentName');
    userPositionId = AppCore.getJsonInt(json, 'userPositionId');
    userPositionName = AppCore.getJsonString(json, 'userPositionName');
    userDepartmentRegistDatetime = AppCore.getJsonString(json, 'userDepartmentRegistDatetime');
  }

  Future<bool> departmentLeave() async {
    String address = '/departmentLeave';
    Map<String, dynamic> body = {
      'userId': userId,
      'departmentId': userDepartmentId,
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

  Future<bool> positionLeave() async {
    String address = '/positionLeave';
    Map<String, dynamic> body = {
      'userId': userId,
      'departmentId': userDepartmentId,
      'positionId': userPositionId,
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