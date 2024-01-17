import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';

import '../../models/department.dart';
import '../../widgets/text_form_field_v1.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class DepartmentManage extends StatefulWidget {
  final Department department;
  const DepartmentManage({super.key, required this.department});

  @override
  State<DepartmentManage> createState() => _DepartmentManage();
}

class _DepartmentManage extends State<DepartmentManage> {
  TextEditingController departmentName = TextEditingController();

  void save(bool departmentActivationStatus) async {
    if (widget.department.departmentName.isEmpty) {
      // ignore: use_build_context_synchronously
      AppCore.showMessage(context, '부서 정보 수정', '부서명이 입력되지 않았습니다', ActionType.ok, () {
        Navigator.pop(context);
      });

      return;
    }

    widget.department.departmentName = departmentName.text;
    widget.department.activationStatus = departmentActivationStatus;

    if (await widget.department.departmentUpdate()) {
      // ignore: use_build_context_synchronously
      AppCore.showMessage(context, '부서 정보 수정', '부서 정보 저장 성공', ActionType.ok, () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
    else {
      // ignore: use_build_context_synchronously
      AppCore.showMessage(context, '부서 정보 수정', '저장 실패. 부서명이 사용되고 있는지 확인하세요', ActionType.ok, () {
        Navigator.pop(context);
      });
    }

    return ;
  }

  @override
  Widget build(BuildContext context) {
    departmentName.text = widget.department.departmentName;

    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '부서 정보',
            ),
            TextFormFieldV1(
              controller: departmentName,
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(
                  child: SizedBox(
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
                        save(!widget.department.activationStatus);
                      },
                      child: Text(
                        widget.department.activationStatus ? '미사용' : '사용',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
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
                        save(widget.department.activationStatus);
                      },
                      child: Text(
                        '저장',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}