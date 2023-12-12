import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/receipt/receipt_approval_list.dart';
import 'package:test/screens/screen_frame.dart';
import 'package:test/widgets/title_text.dart';
import 'package:test/widgets/top_bar.dart';

import '../models/news.dart';
import '../models/receipt.dart';
import '../models/response_data.dart';
import 'receipt/receipt_request.dart';
import 'receipt/receipt_request_list.dart';
import 'news/news_detail.dart';

class Home extends StatefulWidget {
  final int groupId;
  const Home({super.key, required this.groupId});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
  DateTime? curruentBackPressTime;
  List<News> newsList = <News>[];

  @override
  void initState() {
    super.initState();

    getNewsTopList();
  }

  Future<void> getNewsTopList() async {
    String address = '/getNewsTopList';
    Map<String, dynamic> body = {
      'departmentIdList': AppCore.instance.getUser().departmentList.map((e) => e.departmentId).toList(),
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      List<News> tempList = <News>[];

      for (var json in jsonDecode(responseData.body)) {
        News news = News();
        news.setData(json);

        tempList.add(news);
      }

      setState(() {
        newsList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      appBarType: BarType.main,
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequest(receipt: Receipt(),)),);
                                                },
                                                style: ButtonStyle(
                                                  overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                                                ),
                                                child: Text(
                                                  '영수증 제출',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
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
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptApprovalList()),);
                                                },
                                                style: ButtonStyle(
                                                  overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                                                ),
                                                child: Text(
                                                  '영수증 결재',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
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
                                                onPressed: () {
                                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequestList()),);
                                                },
                                                style: ButtonStyle(
                                                  overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                                                ),
                                                child: Text(
                                                  '영수증 제출내역',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 20,
                                                  ),
                                                ),
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
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: '소식',
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: newsList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final news = newsList[index];

                            return GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(id: news.id)),).then((value) {
                                  getNewsTopList();
                                });
                              },
                              child: Column(
                                children: [
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: 55,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Color.fromARGB(31, 0, 0, 0),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    news.title,
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                                    color: Color.fromARGB(236, 214, 215, 252),
                                                  ),
                                                  child: Text(
                                                    news.departmentName,
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(
                                                      news.content,
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                      ),
                                                    )
                                                  ),
                                                ),
                                                Text(
                                                  news.regDatetime.substring(0, 10),
                                                )
                                              ],
                                            )
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ]
                              )
                            );
                          }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}