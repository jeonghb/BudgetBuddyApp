import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:test/widgets/title_text.dart';

import '../../app_core.dart';
import '../../models/Calculate.dart';
import '../../models/response_data.dart';
import '../home.dart';
import '../screen_frame.dart';

class ReceiptCalculate2 extends StatefulWidget {
  final DateTime selectDate;
  final int departmentId;
  final bool isDBData;

  const ReceiptCalculate2({
    super.key,
    required this.selectDate,
    required this.departmentId,
    required this.isDBData,
  });

  @override
  State<ReceiptCalculate2> createState() => _ReceiptCalculate2();
}

class _ReceiptCalculate2 extends State<ReceiptCalculate2> {
  Calculate calculate = Calculate();

  @override
  void initState() {
    super.initState();

    getMonthCalculateData();
    calculate.isDBData = widget.isDBData;
  }

  Future<void> getMonthCalculateData() async {
    String address = '/getMonthCalculateData';
    Map<String, dynamic> body = {
      'departmentId': widget.departmentId,
      'yearMonth': '${widget.selectDate.year}-${widget.selectDate.month.toString().padLeft(2, '0')}',
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      var json = jsonDecode(responseData.body);

      Calculate temp = Calculate();
      temp.setData(json);  

      setState(() {
        calculate = temp;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            TitleText(
              text: '월별 정산',
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.selectDate.year}년도 총 예산 금액',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${NumberFormat('#,##0').format(calculate.yearBudgetAmount)}원',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
              '누적된 정산 금액',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${NumberFormat('#,##0').format(calculate.yearAccumulateAmount)}원',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${widget.selectDate.month}월 정산 금액',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${NumberFormat('#,##0').format(calculate.monthAmount)}원',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '총 누적 정산 금액',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${NumberFormat('#,##0').format(calculate.yearAccumulateAmount + calculate.monthAmount)}원',
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '남은 예산 금액',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '${NumberFormat('#,##0').format(calculate.yearBudgetAmount - (calculate.yearAccumulateAmount + calculate.monthAmount))}원',
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(130),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 90, 68, 223),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                onPressed: () {
                  AppCore.showMessage(context, '월 정산', '${widget.selectDate.year}년 ${widget.selectDate.month}월 정산 처리할까요?', ActionType.yesNo, () async {
                    Navigator.pop(context);

                    if (await calculate.saveMonthCalculate()) {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '월 정산', '정산 처리 완료!', ActionType.ok, () {
                        Navigator.pop(context);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => false);
                      });
                    }
                    else {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '월 정산', '정산 처리 실패', ActionType.ok, () {
                        Navigator.pop(context);
                      });
                    }
                  });
                },
                child: Text(
                  calculate.isDBData ? '재정산' : '정산',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}