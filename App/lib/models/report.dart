import 'package:test/app_core.dart';

import 'response_data.dart';

class Report {
  int id = -1;
  Type type = Type.none;
  int typeId = -1;
  String content = '';
  String reportUserId = '';
  String reportUserName = '';

  void setData(var json) {
    id = AppCore.getJsonInt(json, 'id');
    type = setType(AppCore.getJsonInt(json, 'type'));
    typeId = AppCore.getJsonInt(json, 'typeId');
    content = AppCore.getJsonString(json, 'content');
    reportUserId = AppCore.getJsonString(json, 'reportUserId');
    reportUserName = AppCore.getJsonString(json, 'reportUserName');
  }

  Type setType(int value) {
    Type returnType = Type.none;

    switch (value) {
      case 1:
        returnType = Type.news;
      break;
      default:
        returnType = Type.none;
      break;
    }

    return returnType;
  }

  int getType() {
    int returnValue = -1;

    switch (type) {
      case Type.none:
        returnValue = -1;
      break;
      case Type.news:
        returnValue = 0;
      break;
    }

    return returnValue;
  }

  Future<bool> reportAdd() async {
    String address = '/reportAdd';
    Map<String, dynamic> body = {
      'type': getType(),
      'typeId': typeId,
      'content': content,
      'reportUserId': AppCore.instance.getUser().userId,
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

enum Type {
  none,
  news,
}