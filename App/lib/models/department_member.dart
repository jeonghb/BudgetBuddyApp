import '../app_core.dart';
import 'response_data.dart';

class DepartmentMember {
  int departmentId = -1;
  String departmentName = '';
  String userId = '';
  String userName = '';
  int positionId = -1;
  String positionName = '';

  void fromJson(Map<String, dynamic> json) {
    departmentId = int.parse(json['departmentId']);
    departmentName = json['departmentName'].toString();
    userName = json['userName'].toString();
    positionId = int.parse(json['positionId']);
    positionName = json['positionName'].toString();
  }

  Future<bool> leave() async {
    String address = '/DepartmentLeave';
    Map<String, String> body = {
      'userId': userId,
      'departmentId': departmentId.toString(),
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