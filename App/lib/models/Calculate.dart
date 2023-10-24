import 'package:test/app_core.dart';

import 'response_data.dart';

class Calculate {
  int departmentId = -1;
  String yearMonth = ''; // 'yyyy-MM'
  int yearBudgetAmount = 0; // 연 예산금액
  int yearAccumulateAmount = 0; // 누적된 정산 금액
  int monthAmount = 0; // 추가로 정산할 금액
  String regUserId = '';
  String regUserName = '';
  String modUserId = '';
  String modUserName = '';
  bool isDBData = false; // DB에 이미 저장되어있는지 여부

  void setData(var json) {
    departmentId = AppCore.getJsonInt(json, 'departmentId');
    yearMonth = AppCore.getJsonString(json, 'yearMonth');
    yearBudgetAmount = AppCore.getJsonInt(json, 'yearBudgetAmount');
    yearAccumulateAmount = AppCore.getJsonInt(json, 'yearAccumulateAmount');
    monthAmount = AppCore.getJsonInt(json, 'monthAmount');
    regUserId = AppCore.getJsonString(json, 'regUserId');
    regUserName = AppCore.getJsonString(json, 'regUserName');
    modUserId = AppCore.getJsonString(json, 'modUserId');
    modUserName = AppCore.getJsonString(json, 'modUserName');
    isDBData = AppCore.getJsonBool(json, 'isDBData');
  }

  Future<bool> saveMonthCalculate() async {
    String address = '';
    if (isDBData) {
      address = '/monthCalculateUpdate';
    }
    else {
      address = '/monthCalculateAdd';
    }

    Map<String, dynamic> body = {
      'departmentId': departmentId,
      'yearMonth': yearMonth,
      'monthAmount': monthAmount,
      (isDBData ? 'modUserId' : 'regUserId') : AppCore.instance.getUser().userId.text,
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