import 'dart:convert';

import 'package:test/app_core.dart';

import 'response_data.dart';

class Group {
  int groupId = -1;
  String groupName = '';
  String groupIntroduceMemo = '';
  int groupUserCount = -1;
  bool groupMaster = false;
  bool groupStatus = false;

  void setData(var json) {
    groupId = AppCore.getJsonInt(json, 'groupId');
    groupName = AppCore.getJsonString(json, 'groupName');
    groupIntroduceMemo = AppCore.getJsonString(json, 'groupIntroduceMemo');
    groupUserCount = AppCore.getJsonInt(json, 'groupUserCount');
    groupMaster = AppCore.getJsonBool(json, 'groupMaster');
    groupStatus = AppCore.getJsonBool(json, 'groupStatus');
  }

  Future<bool> groupAdd() async {
    String address = '/groupAdd';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
      'groupName': groupName,
      'groupIntroduceMemo': groupIntroduceMemo,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      var json = jsonDecode(responseData.body);
      if (AppCore.getJsonBool(json, 'success')) {
        setData(json);
        
        AppCore.instance.getUser().groupList.add(this);
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