import 'package:test/app_core.dart';

import 'response_data.dart';

class GroupMember {
  String userId = '';
  String userName = '';
  String userEmail = '';
  String userPhoneNumber = '';
  String userBirthday = '';
  String userSex = 'male';

  void setData(var json) {
    userId = AppCore.getJsonString(json, 'userId');
    userName = AppCore.getJsonString(json, 'userName');
    userEmail = AppCore.getJsonString(json, 'userEmail');
    userPhoneNumber = AppCore.getJsonString(json, 'userPhoneNumber');
    userBirthday = AppCore.getJsonString(json, 'userBirthday');
    userSex = AppCore.getJsonString(json, 'userSex');
  }

  Future<bool> groupManagerUpdate() async {
    String address = '/groupManagerUpdate';
    Map<String, dynamic> body = {
      'groupId': AppCore.instance.getUser().selectGroupId,
      'newManagerUserId': userId,
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