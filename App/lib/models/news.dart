import 'package:test/app_core.dart';

import 'response_data.dart';

class News {
  int id = -1;
  int departmentId = -1;
  String departmentName = '';
  String title = '';
  String content = '';
  String regUserId = '';
  String regUserName = '';
  String regDatetime = DateTime.now().toString();
  String modDatetime = DateTime.now().toString();
  String delUserId = '';
  String delUserName = '';
  String delDatetime = DateTime.now().toString();

  void setData(var json) {
    id = AppCore.getJsonInt(json, 'id');
    departmentId = AppCore.getJsonInt(json, 'departmentId');
    departmentName = AppCore.getJsonString(json, 'departmentName');
    title = AppCore.getJsonString(json, 'title');
    content = AppCore.getJsonString(json, 'content');
    regUserId = AppCore.getJsonString(json, 'regUserId');
    regUserName = AppCore.getJsonString(json, 'regUserName');
    regDatetime = AppCore.getJsonString(json, 'regDatetime');
    modDatetime = AppCore.getJsonString(json, 'modDatetime');
    delUserId = AppCore.getJsonString(json, 'delUserId');
    delUserName = AppCore.getJsonString(json, 'delUserName');
    delDatetime = AppCore.getJsonString(json, 'delDatetime');
  }

  Future<bool> newsAdd() async {
    String address = '/newsAdd';
    Map<String, dynamic> body = {
      'departmentId': departmentId,
      'title': title,
      'content': content,
      'regUserId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> newsEdit() async {
    String address = '/newsEdit';
    Map<String, dynamic> body = {
      'id': id,
      'departmentId': departmentId,
      'title': title,
      'content': content,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }

  Future<bool> newsDelete() async {
    String address = '/newsDelete';
    Map<String, dynamic> body = {
      'id': id,
      'delUserId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      return true;
    }
    else {
      return false;
    }
  }
}