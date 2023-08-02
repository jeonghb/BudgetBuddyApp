import '../app_core.dart';
import 'response_data.dart';

class DepartmentRequest {
  String requestUserId = '';
  String requestUserName = '';
  String requestUserBirthday = DateTime.now().toString();
  String requestUserSex = 'male';
  int requestDepartmentId = -1;
  String requestDepartmentName = '';
  String requestDatetime = DateTime.now().toString();
  String approvalUserId = '';
  String approvalUserName = '';
  int approvalStatus = -1;

  void setData(var json) {
    // requestUserId = json['requestUserId'];
    // requestUserName = json['requestUserName'];
    // requestUserBirthday = json['requestUserBirthday'];
    // requestUserSex = json['requestUserSex'];
    // requestDepartmentId = int.parse(json['requestDepartmentId'].toString());
    // requestDepartmentName = json['requestDepartmentName'];
    // requestDatetime = json['requestDatetime'];
    // approvalUserId = json['approvalUserId'];
    // approvalUserName = json['approvalUserName'];
    // approvalStatus = int.parse(json['approvalStatus'].toString());

    requestUserId = AppCore.getJsonString(json, 'requestUserId');
    requestUserName = AppCore.getJsonString(json, 'requestUserName');
    requestUserBirthday = AppCore.getJsonString(json, 'requestUserBirthday');
    requestUserSex = AppCore.getJsonString(json, 'requestUserSex');
    requestDepartmentId = AppCore.getJsonInt(json, 'requestDepartmentId');
    requestDepartmentName = AppCore.getJsonString(json, 'requestDepartmentName');
    requestDatetime = AppCore.getJsonString(json, 'requestDatetime');
    approvalUserId = AppCore.getJsonString(json, 'approvalUserId');
    approvalUserName = AppCore.getJsonString(json, 'approvalUserName');
    approvalStatus = AppCore.getJsonInt(json, 'approvalStatus');
  }

  Future<bool> requestFinish() async {
    String address = '/departmentRequestFinish';
    Map<String, String> body = {
      'requestUserId': requestUserId,
      'requestDepartmentId': requestDepartmentId.toString(),
      'approvalUserId': AppCore.instance.getUser().userId.text,
      'approvalStatus': approvalStatus.toString(),
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