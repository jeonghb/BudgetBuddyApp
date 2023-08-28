import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/widgets/text_form_field_v1.dart';

import '../../models/response_data.dart';
import '../screen_frame.dart';

class InquiryRequest extends StatefulWidget {
  const InquiryRequest({super.key});

  @override
  State<InquiryRequest> createState() => _InquiryRequest();
}

class _InquiryRequest extends State<InquiryRequest> {
  TextEditingController inquiryTitle = TextEditingController();
  TextEditingController inquiryMemo = TextEditingController();

  String setData() {
    if (inquiryTitle.text.isEmpty) {
      return '제목이 입력되지 않았습니다.';
    }
    else if (inquiryMemo.text.isEmpty) {
      return '내용이 입력되지 않았습니다.';
    }

    return '';
  }

  Future<bool> inquiryRequest() async {
    String address = '/inquiryRequest';
    Map<String, dynamic> body = {
      'inquiryUserId': AppCore.instance.getUser().userId.text,
      'inquiryTitle': inquiryTitle.text,
      'inquiryMemo': inquiryMemo.text,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      if (responseData.body == 'true') {
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '문의하기',
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '제목',
            ),
            TextFormFieldV1(
              controller: inquiryTitle,
              keyboardType: TextInputType.text,
            ),
            TextFormFieldV1(
              controller: inquiryMemo,
              keyboardType: TextInputType.text,
            ),
            SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: () async {
                String validationMessage = setData();
                if (validationMessage.isNotEmpty) {
                  AppCore.showMessage(context, '문의하기', validationMessage, ActionType.ok, () {
                    Navigator.pop(context);
                  });
                }
                else if (await inquiryRequest()) {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '문의하기', '문의를 요청하였습니다.', ActionType.ok, () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                }
                else {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '문의하기', '요청 실패', ActionType.ok, () {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text(
                '문의하기',
              )
            ),
          ]
        ),
      ),
    );
  }
}