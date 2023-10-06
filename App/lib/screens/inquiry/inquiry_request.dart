import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/widgets/text_form_field_v1.dart';
import 'package:test/widgets/title_text.dart';

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: '문의하기',
              ),
              Text(
                '제목',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldV1(
                controller: inquiryTitle,
                keyboardType: TextInputType.text,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '문의내용',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldV1(
                controller: inquiryMemo,
                keyboardType: TextInputType.multiline,
                suffixIcon: Text(''),
                maxLength: 1000,
                maxLines: 10,
              ),
              SizedBox(
                height: 10,
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
                    '제출',
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