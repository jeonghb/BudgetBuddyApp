import 'package:flutter/material.dart';
import 'package:test/widgets/title_text.dart';

import '../../models/inquiry.dart';
import '../screen_frame.dart';

class InquiryManage extends StatefulWidget {
  final Inquiry inquiry;
  const InquiryManage({super.key, required this.inquiry});

  @override
  State<InquiryManage> createState() => _InquiryManage();
}

class _InquiryManage extends State<InquiryManage> {
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          TitleText(
            text: '문의내용',
          ),
          Text(
            '제목 : ${widget.inquiry.inquiryTitle}',
          ),
          Text(
            '문의일시 : ${widget.inquiry.inquiryDatetime}',
          ),
          Text(
            '내용 : ${widget.inquiry.inquiryMemo}',
          ),
          Text(
            '답변 : ${widget.inquiry.inquiryAnswer}',
          ),
        ]
      ),
    );
  }
}