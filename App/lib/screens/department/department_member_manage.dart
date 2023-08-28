import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/screen_frame.dart';

import '../../models/department_member.dart';

class DepartmentMemberManage extends StatefulWidget {
  final DepartmentMember departmentMember;

  const DepartmentMemberManage({super.key, required this.departmentMember});

  @override
  State<DepartmentMemberManage> createState() => _DepartmentMemberManage();
}

class _DepartmentMemberManage extends State<DepartmentMemberManage> {
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '부서원 정보',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            widget.departmentMember.userName,
          ),
          Text(
            widget.departmentMember.userDepartmentName,
          ),
          TextButton(
            onPressed: () {
              AppCore.showMessage(context, '부서 해지', '${widget.departmentMember.userName}님을 해지하시겠습니까?', ActionType.yesNo, () {
                Navigator.pop(context);
                widget.departmentMember.leave().then((bool result) {
                  if (result) {
                    Navigator.pop(context);
                  }
                  else {
                    AppCore.showMessage(context, '부서 해지', '해지 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                      Navigator.pop(context);
                    });
                  }
                });
                Navigator.pop(context);
              });
            },
            child: Text(
              '부서 소속 해지'
            )
          ),
        ],
      )
    );
  }
}