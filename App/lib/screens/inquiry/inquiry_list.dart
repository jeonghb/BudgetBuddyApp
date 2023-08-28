import 'dart:convert';

import 'package:flutter/material.dart';

import '../../app_core.dart';
import '../../models/inquiry.dart';
import '../../models/response_data.dart';
import '../screen_frame.dart';
import 'inquiry_manage.dart';

class InquiryList extends StatefulWidget {
  const InquiryList({super.key});

  @override
  State<InquiryList> createState() => _InquiryList();
}

class _InquiryList extends State<InquiryList> {
  List<Inquiry> inquiryList = <Inquiry>[];

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

      setState(() {
        inquiryList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '문의내역',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: inquiryList.length,
            itemBuilder: (BuildContext context, int index) {
              final inquiry = inquiryList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InquiryManage(inquiry: inquiry,)),).then((value) {
                    if (value == true) {
                      getInquiryList();
                    }
                  });
                },
                child: Column (
                  children: [
                    ListTile(
                      leading: Text(inquiry.inquiryTitle),
                      
                    ),
                    Divider(),
                  ]
                ),
              );
            }
          )
        ],
      ),
    );
  }
}