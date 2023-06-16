import 'package:flutter/material.dart';
import 'package:test/screens/receipt_calculate.dart';
import 'package:test/screens/receipt_list.dart';
import 'package:test/widgets/menu_drawer.dart';
import 'package:test/widgets/top_bar.dart';

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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        appBar: TopBar(),
        endDrawer: MenuDrawer(),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
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
        )
      )
    );
  }
}