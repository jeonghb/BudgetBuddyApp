import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test/screens/receipt_calculate.dart';
import 'package:test/screens/receipt_list.dart';
import 'package:test/screens/screen_frame.dart';

import '../app_core.dart';
import '../models/receipt.dart';
import 'budget_add.dart';
import 'receipt_request.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  DateTime? curruentBackPressTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: ScreenFrame(
        body : Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequest(receipt: Receipt(),)),);
                  },
                  child: Text('영수증 제출')
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetAdd()),);
                //   },
                //   child: Text('예산 추가')
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptList(submissionStatus: 1)),);
                  },
                  child: Text('영수증 결재')
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptList(submissionStatus: -1)),);
                  },
                  child: Text('제출 내역')
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptCalculate(departmentId: AppCore.getInstance().getUser().getDepartmentId(),)),);
                  },
                  child: Text('월별 정산')
                ),
              ]
            )
          )
        )
      ),
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (curruentBackPressTime == null || now.difference(curruentBackPressTime!) > Duration(seconds: 2)) {
          curruentBackPressTime = now;
          Fluttertoast.showToast(msg: "뒤로가기 버튼을 한번 더 누르면 종료됩니다");
          return false;
        }
        return true;
      }
    );
  }
}