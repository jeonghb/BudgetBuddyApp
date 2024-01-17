import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/widgets/text_form_field_v1.dart';

import '../../app_core.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class DepartmentAdd extends StatefulWidget {
  const DepartmentAdd({super.key});

  @override
  State<DepartmentAdd> createState() => _DepartmentAdd();
}

class _DepartmentAdd extends State<DepartmentAdd> {
  TextEditingController departmentName = TextEditingController();

  String validationCheck() {
    if (departmentName.text.isEmpty) {
      return '부서명을 입력하세요';
    }

    return '';
  }

  Future<bool> departmentAdd() async {
    String address = '/departmentAdd';
    Map<String, dynamic> body = {
      'groupId': AppCore.instance.getUser().selectGroup.groupId,
      'departmentName' : departmentName.text,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      if (responseData.body.toString() == 'true') {
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
            TitleText(
              text: '부서 추가',
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '부서명',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormFieldV1(
              controller: departmentName,
            ),
            SizedBox(
              height: 30,
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
                  String validationMessage = validationCheck();
                  if (validationMessage.isNotEmpty) {
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '부서 추가', validationMessage, ActionType.ok, () {
                      Navigator.pop(context);
                    });
                  }

                  if (await departmentAdd()) {
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '부서 추가', '부서 추가 완료', ActionType.ok, () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  }
                  else {
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '부서 추가', '부서 추가 실패. 해당 부서명이 추가되어 있는지 확인하세요', ActionType.ok, () {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text(
                  '추가',
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