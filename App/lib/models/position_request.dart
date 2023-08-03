import '../app_core.dart';
import 'response_data.dart';

class PositionRequest {
  String requestUserId = '';
  String requestUserName = '';
  String requestUserBirthDay = DateTime.now().toString();
  String requestUserSex = 'male';
  int requestDepartmentId = -1;
  String requestDepartmentName = '';
  int requestPositionId = -1;
  String requestPositionName = '';
  bool requestResult = false;

  Future<bool> requestFinish() async {
    String address = '/PositionRequestFinish';
    Map<String, String> body = {
      'userId': requestUserId,
      'departmentId': requestDepartmentId.toString(),
      'positionId' : requestPositionId.toString(),
      'requestResult': requestResult.toString(),
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