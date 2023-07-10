import '../app_core.dart';
import 'response_data.dart';

class DepartmentRequest {
  String requestUserId = '';
  String requestUserName = '';
  String requestUserBirthDay = DateTime.now().toString();
  String requestUserSex = 'male';
  int requestDepartmentId = -1;
  String requestDepartmentName = '';
  bool requestResult = false;

  Future<bool> requestFinish() async {
    String address = '/DepartmentRequestFinish';
    Map<String, String> body = {
      'userId': requestUserId,
      'departmentId': requestDepartmentId.toString(),
      'requestResult': requestResult.toString(),
    };

    ResponseData responseData = await AppCore.request(address, body);

    if (responseData.statusCode == 200) {
      if (responseData.body == '1') {
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