import 'package:test/models/budget.dart';

import 'calculate.dart';
import 'receipt.dart';

class CalculateMail {
  String title = '';
  List<Receipt> receiptList = <Receipt>[];
  int remainBudgetAmount = 0;

  void setData(Calculate calculate) {
    title = '${calculate.yearMonth.substring(0, 4)}년 ${calculate.departmentName} 예산 사용내역 (${int.parse(calculate.yearMonth.substring(5, 7))}월)';

    receiptList.addAll(calculate.receiptList);

    for (Budget budget in calculate.budgetList) {
      Receipt receipt = Receipt();
      receipt.budgetTypeName = budget.budgetTypeName;
      receipt.title = budget.budgetTitle;
      receipt.requestAmount = budget.budgetAmount;
      receipt.requestUserName = budget.userName;
      receipt.paymentDatetime = budget.budgetDate; // 정렬하기 위해 필요
      receipt.approvalDatetime = '';

      receiptList.add(receipt);
    }

    receiptList.sort((a, b) => a.paymentDatetime.compareTo(b.paymentDatetime));
    for (Receipt receipt in receiptList) {
      if (receipt.approvalDatetime.isEmpty) {
        receipt.paymentDatetime = '';
        receipt.sendDatetime = '';
      }
    }


    remainBudgetAmount = calculate.yearBudgetAmount - calculate.yearAccumulateAmount;
  }
}