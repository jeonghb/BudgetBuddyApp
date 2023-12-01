import 'package:test/app_core.dart';

class GroupUser {
  String userId = '';
  String userName = '';
  String userBirthday = '';
  String userSex = 'male';

  void setData(var json) {
    userId = AppCore.getJsonString(json, 'userId');
    userName = AppCore.getJsonString(json, 'userName');
    userBirthday = AppCore.getJsonString(json, 'userBirthday');
    userSex = AppCore.getJsonString(json, 'userSex');
  }
}