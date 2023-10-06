import 'dart:convert';

import 'package:flutter/material.dart';

import '../../app_core.dart';
import '../../models/inquiry.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';
import 'inquiry_detail.dart';

class InquiryList extends StatefulWidget {
  const InquiryList({super.key});

  @override
  State<InquiryList> createState() => _InquiryList();
}

class _InquiryList extends State<InquiryList> {
  List<Inquiry> inquiryList = <Inquiry>[];
  List<Inquiry> inquiryFilterList = <Inquiry>[];
  FilterType filterType = FilterType.complete;

  @override
  void initState() {
    super.initState();

    getInquiryList();
  }

  void getInquiryList() async {
    String address = '/getInquiryList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId.text,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      List<Inquiry> tempList = <Inquiry>[];
      
      for (var json in jsonDecode(responseData.body))
      {
        Inquiry inquiry = Inquiry();
        inquiry.setData(json);

        tempList.add(inquiry);
      }

      inquiryList = tempList;
      filterInquiryList();
    }
  }

  void filterInquiryList() {
    switch (filterType) {
      case FilterType.all:
        setState(() {
          inquiryFilterList = inquiryList;
        });
      break;
      case FilterType.complete:
        setState(() {
          inquiryFilterList = inquiryList.where((element) => element.inquiryAnswer.isNotEmpty).toList();
        });
      break;
      case FilterType.wait:
        setState(() {
          inquiryFilterList = inquiryList.where((element) => element.inquiryAnswer.isEmpty).toList();
        });
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TitleText(
              text: '나의 문의',
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 35,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        filterType = FilterType.all;
                        filterInquiryList();
                      },
                      child: Text(
                        '전체',
                        style: TextStyle(
                          fontSize: 14,
                          color: filterType == FilterType.all ? Colors.black : Colors.grey[300],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    '|'
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        filterType = FilterType.complete;
                        filterInquiryList();
                      },
                      child: Text(
                        '완료',
                        style: TextStyle(
                          fontSize: 14,
                          color: filterType == FilterType.complete ? Colors.black : Colors.grey[300],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    '|'
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        filterType = FilterType.wait;
                        filterInquiryList();
                      },
                      child: Text(
                        '대기',
                        style: TextStyle(
                          fontSize: 14,
                          color: filterType == FilterType.wait ? Colors.black : Colors.grey[300],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 7,
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: inquiryFilterList.length,
                itemBuilder: (BuildContext context, int index) {
                  final inquiry = inquiryFilterList[index];

                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => InquiryDetail(inquiry: inquiry,)),);
                      getInquiryList();
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 80,
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
                                  child: Text(
                                    inquiry.inquiryTitle,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        inquiry.inquiryAnswer.isNotEmpty ? '답변완료' : '답변대기',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: inquiry.inquiryAnswer.isNotEmpty ? Colors.blue : Colors.black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        ' | '
                                      ),
                                      Text(
                                         inquiry.inquiryDatetime.substring(0, 10),
                                      ),
                                    ]
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}

enum FilterType {
  all,
  complete,
  wait,
}