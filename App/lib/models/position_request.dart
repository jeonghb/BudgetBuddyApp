import '../app_core.dart';
import 'response_data.dart';

class PositionRequest {
  String requestUserId = '';
  String requestUserName = '';
  String requestUserBirthday = DateTime.now().toString();
  String requestUserSex = 'male';
  int requestDepartmentId = -1;
  String requestDepartmentName = '';
  int requestPositionId = -1;
  String requestPositionName = '';
  String requestDatetime = DateTime.now().toString();
  String approvalUserId = '';
  String approvalUserName = '';
  int approvalStatus = -1;

  void setData(var json) {
    requestUserId = AppCore.getJsonString(json, 'requestUserId');
    requestUserName = AppCore.getJsonString(json, 'requestUserName');
    requestUserBirthday = AppCore.getJsonString(json, 'requestUserBirthday');
    requestUserSex = AppCore.getJsonString(json, 'requestUserSex');
    requestDepartmentId = AppCore.getJsonInt(json, 'requestDepartmentId');
    requestDepartmentName = AppCore.getJsonString(json, 'requestDepartmentName');
    requestPositionId = AppCore.getJsonInt(json, 'requestPositionId');
    requestPositionName = AppCore.getJsonString(json, 'requestPositionName');
    approvalUserId = AppCore.getJsonString(json, 'approvalUserId');
    approvalUserName = AppCore.getJsonString(json, 'approvalUserName');
    approvalStatus = AppCore.getJsonInt(json, 'approvalStatus');
  }

  Future<bool> requestFinish() async {
    String address = '/positionRequestFinish';
    Map<String, dynamic> body = {
      'requestUserId': requestUserId,
      'requestDepartmentId': requestDepartmentId,
      'requestPositionId': requestPositionId,
      'approvalUserId': AppCore.instance.getUser().userId.text,
      'approvalStatus': approvalStatus,
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