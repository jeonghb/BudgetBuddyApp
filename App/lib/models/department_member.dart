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

  void fromJson(Map<String, dynamic> json) {
    userId = AppCore.getJsonString(json, 'userId');
    userName = AppCore.getJsonString(json, 'userName');
    userBirthday = AppCore.getJsonString(json, 'userBirthday');
    userSex = AppCore.getJsonString(json, 'userSex');
    userDepartmentId = AppCore.getJsonInt(json, 'userDepartmentId');
    userDepartmentName = AppCore.getJsonString(json, 'userDepartmentName');
    userPositionId = AppCore.getJsonInt(json, 'userPositionId');
    userPositionName = AppCore.getJsonString(json, 'userPositionName');
  }

  Future<bool> leave() async {
    String address = '/DepartmentLeave';
    Map<String, String> body = {
      'userId': userId,
      'userDepartmentId': userDepartmentId.toString(),
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      if (responseData.body == '1') {
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