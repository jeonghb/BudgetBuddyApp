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
    return ScreenFrame(
      isAppBar: true,
      isDrawer: true,
      body: WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();
          if (curruentBackPressTime == null || now.difference(curruentBackPressTime!) > Duration(seconds: 2)) {
            curruentBackPressTime = now;
            Fluttertoast.showToast(msg: "뒤로가기 버튼을 한번 더 누르면 종료됩니다");
            return false;
          }
          return true;
        },
        child : Column(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-0.97, 0.25),
                    end: Alignment(0.97, -0.25),
                    colors: const [Color(0xFF9B5EFF), Color(0xFF5A44DF)],
                  ),
                ),
                width: MediaQuery.sizeOf(context).width,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(),
                              ),
                              Expanded(
                                child: Image.asset('assets/images/homeReceiptImage.png'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width,
                            child: Row(
                              children: const [
                                Expanded(
                                  child: SizedBox()
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    'WELLCOME!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ),
                                Expanded(
                                  flex: 2,
                                  child: SizedBox(),
                                ),
                              ]
                            ),
                          )
                        ),
                        Expanded(
                          flex: 5,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox()
                              ),
                              Expanded(
                                flex: 8,
                                child: Container(
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white,
                                ),
                                  width: MediaQuery.sizeOf(context).width,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Image.asset('assets/images/receiptRequest.png'),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: TextButton(
                                                child: Text(
                                                  '영수증 제출',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequest(receipt: Receipt(),)),);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: Icon(
                                                Icons.arrow_circle_right_outlined,
                                                color: Color.fromARGB(255, 90, 68, 223)),
                                            ),
                                          ]
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Image.asset('assets/images/receiptApproval.png'),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: TextButton(
                                                child: Text(
                                                  '영수증 결재',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptList(submissionStatus: 1)),);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: Icon(
                                                Icons.arrow_circle_right_outlined,
                                                color: Color.fromARGB(255, 90, 68, 223)),
                                            ),
                                          ]
                                        ),
                                      ),
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Image.asset('assets/images/receiptList.png'),
                                            ),
                                            Expanded(
                                              flex: 4,
                                              child: TextButton(
                                                child: Text(
                                                  '영수증 제출내역',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptList(submissionStatus: -1)),);
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: Icon(
                                                Icons.arrow_circle_right_outlined,
                                                color: Color.fromARGB(255, 90, 68, 223)),
                                            ),
                                          ]
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              ),
                              Expanded(
                                child: SizedBox()
                              ),
                            ],
                          )
                        ),
                        Expanded(
                          child: SizedBox(),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                color: Colors.white,
              ),
            ),
          ],
        )
      ),
    );
  }
}