import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/widgets/title_text.dart';

import '../../models/inquiry.dart';
import '../screen_frame.dart';

class InquiryDetail extends StatefulWidget {
  final Inquiry inquiry;
  const InquiryDetail({super.key, required this.inquiry});

  @override
  State<InquiryDetail> createState() => _InquiryDetail();
}

class _InquiryDetail extends State<InquiryDetail> {
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: '문의내용',
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.inquiry.inquiryTitle,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month,
                    color: Colors.grey,
                  ),
                  Text(
                    '  ${widget.inquiry.inquiryDatetime.substring(0, 10)}',
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Color.fromARGB(255, 90, 68, 223),
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '문의내용',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.inquiry.inquiryMemo,
              ),
              SizedBox(
                height: 10,
              ),
              Divider(
                color: Color.fromARGB(255, 90, 68, 223),
                thickness: 2,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '답변',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.inquiry.inquiryAnswer,
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(130),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '목록',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}