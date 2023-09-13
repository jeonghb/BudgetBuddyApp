import 'package:flutter/material.dart';
import 'package:test/app_core.dart';

import '../../models/department_request.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class DepartmentRequestManage extends StatefulWidget {
  final DepartmentRequest departmentRequest;

  const DepartmentRequestManage({super.key, required this.departmentRequest});

  @override
  State<DepartmentRequestManage> createState() => _DepartmentRequestManage();
}

class _DepartmentRequestManage extends State<DepartmentRequestManage> {
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          TitleText(
            text: '부서 신청 정보',
          ),
          Row(
            children: [
              Text(
                '신청자',
              ),
              Text(
                widget.departmentRequest.requestUserName,
              )
            ],
          ),
          Row(
            children: [
              Text(
                '생년월일',
              ),
              Text(
                widget.departmentRequest.requestUserBirthday,
              )
            ],
          ),
          Row(
            children: [
              Text(
                '성별',
              ),
              Text(
                widget.departmentRequest.requestUserSex,
              )
            ],
          ),
          Row(
            children: [
              Text(
                '신청부서',
              ),
              Text(
                widget.departmentRequest.requestDepartmentName,
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  AppCore.showMessage(context, '부서 요청 거부', '${widget.departmentRequest.requestUserName}님을 거부하시겠습니까?', ActionType.yesNo, () {
                    Navigator.pop(context);
                    widget.departmentRequest.approvalStatus = 0;
                    widget.departmentRequest.requestFinish().then((bool result) {
                      if (!result) {
                        AppCore.showMessage(context, '부서 신청 거부', '거부 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                          Navigator.pop(context);
                        });
                      }
                    });
                    Navigator.pop(context, true);
                  });
                },
                child: Text(
                  '거부'
                ),
              ),
              TextButton(
                onPressed: () {
                  AppCore.showMessage(context, '부서 요청 승인', '${widget.departmentRequest.requestUserName}님을 승인하시겠습니까?', ActionType.yesNo, () {
                    Navigator.pop(context);
                    widget.departmentRequest.approvalStatus = 2;
                    widget.departmentRequest.requestFinish().then((bool result) {
                      if (!result) {
                        AppCore.showMessage(context, '부서 신청 승인', '승인 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                          Navigator.pop(context);
                        });
                      }
                    });
                    Navigator.pop(context, true);
                  });
                },
                child: Text(
                  '승인'
                ),
              )
            ],
          )
        ]
      )
    );
  }
}