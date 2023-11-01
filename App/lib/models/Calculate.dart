import 'package:test/app_core.dart';

import 'budget.dart';
import 'receipt.dart';
import 'response_data.dart';

class Calculate {
  int departmentId = -1;
  String departmentName = '';
  String yearMonth = ''; // 'yyyy-MM'
  int yearBudgetAmount = 0; // 연 예산금액
  int yearAccumulateAmount = 0; // 누적된 정산 금액
  int monthBudgetAmount = 0; // 해당 월 예산 추가된 총 금액
  int monthReceiptAmount = 0; // 해당 월 영수증 총 금액
  String regUserId = '';
  String regUserName = '';
  String modUserId = '';
  String modUserName = '';
  bool isDBData = false; // DB에 이미 저장되어있는지 여부
  int dataCount = 0; // 해당 월에 존재하는 영수증, 예산추가 데이터 수
  List<Budget> budgetList = <Budget>[]; // 해당 월에 있는 예산
  List<Receipt> receiptList = <Receipt>[]; // 해당 월에 있는 영수증

  void setData(var json) {
    departmentId = AppCore.getJsonInt(json, 'departmentId');
    departmentName = AppCore.getJsonString(json, 'departmentName');
    yearMonth = AppCore.getJsonString(json, 'yearMonth');
    yearBudgetAmount = AppCore.getJsonInt(json, 'yearBudgetAmount');
    yearAccumulateAmount = AppCore.getJsonInt(json, 'yearAccumulateAmount');
    monthBudgetAmount = AppCore.getJsonInt(json, 'monthBudgetAmount');
    monthReceiptAmount = AppCore.getJsonInt(json, 'monthReceiptAmount');
    regUserId = AppCore.getJsonString(json, 'regUserId');
    regUserName = AppCore.getJsonString(json, 'regUserName');
    modUserId = AppCore.getJsonString(json, 'modUserId');
    modUserName = AppCore.getJsonString(json, 'modUserName');
    isDBData = AppCore.getJsonBool(json, 'isDBData');
    dataCount = AppCore.getJsonInt(json, 'dataCount');
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
      'monthBudgetAmount': monthBudgetAmount,
      'monthReceiptAmount': monthReceiptAmount,
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