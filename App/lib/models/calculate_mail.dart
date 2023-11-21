import 'calculate.dart';
import 'receipt.dart';

class CalculateMail {
  String title = '2023년 청년부 예산 사용내역 (4월)';
  List<Receipt> receiptList = <Receipt>[];
  int yearBudgetAmount = 0;

  void setData(Calculate calculate) {
    title = calculate.yearMonth;
    // title = '${calculate.yearMonth.substring(0, 4)}년 ${calculate.departmentName} 예산 사용내역 (${int.parse(calculate.yearMonth.substring(5, 2))}월)';

    yearBudgetAmount = calculate.yearBudgetAmount;
  }

  Map<String, dynamic> getMail() {
    Map<String, dynamic> body = {
    };

    return body;
  }
}