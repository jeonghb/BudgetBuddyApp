import '../app_core.dart';
import 'response_data.dart';

class DepartmentRequest {
  int id = -1;
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
  bool isCheck = false; // department_request_list에서 선택 기능때 사용

  void setData(var json) {
    id = AppCore.getJsonInt(json, 'id');
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
    Map<String, dynamic> body = {
      'id': id,
      'requestUserId': requestUserId,
      'requestDepartmentId': requestDepartmentId,
      'approvalUserId': AppCore.instance.getUser().userId,
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