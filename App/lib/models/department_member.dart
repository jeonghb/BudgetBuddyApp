import '../app_core.dart';
import 'response_data.dart';

class DepartmentMember {
  String userId = '';
  String userName = '';
  String userBirthday = DateTime.now().toString();
  String userSex = 'male';
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
    userDepartmentId = AppCore.getJsonInt(json, 'userDepartmentId');
    userDepartmentName = AppCore.getJsonString(json, 'userDepartmentName');
    userPositionId = AppCore.getJsonInt(json, 'userPositionId');
    userPositionName = AppCore.getJsonString(json, 'userPositionName');
    userDepartmentRegistDatetime = AppCore.getJsonString(json, 'userDepartmentRegistDatetime');
  }

  Future<bool> leave() async {
    String address = '/departmentLeave';
    Map<String, dynamic> body = {
      'userId': userId,
      'departmentId': userDepartmentId,
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