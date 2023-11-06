import 'package:test/app_core.dart';

class Group {
  int groupId = -1;
  String groupName = '';
  String groupMemo = '';
  int groupUserCount = -1;
  bool groupStatus = false;

  void setData(var json) {
    groupId = AppCore.getJsonInt(json, 'groupId');
    groupName = AppCore.getJsonString(json, 'groupName');
    groupMemo = AppCore.getJsonString(json, 'groupMemo');
    groupUserCount = AppCore.getJsonInt(json, 'groupUserCount');
    groupStatus = AppCore.getJsonBool(json, 'groupStatus');
  }
}