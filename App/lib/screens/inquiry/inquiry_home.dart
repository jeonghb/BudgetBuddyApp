import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/screens/inquiry/inquiry_list.dart';
import 'package:test/screens/inquiry/inquiry_request.dart';
import 'package:test/widgets/title_text.dart';

import '../screen_frame.dart';

class InquiryHome extends StatefulWidget {
  const InquiryHome({super.key});

  @override
  State<InquiryHome> createState() => _InquiryHome();
}

class _InquiryHome extends State<InquiryHome> {
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '궁금한 점이\n있으신가요?'
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
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InquiryRequest()));
                },
                child: Text(
                  '문의하기',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InquiryList()));
                },
                child: Text(
                  '문의내역',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}