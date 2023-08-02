import 'package:flutter/material.dart';
import 'package:test/screens/screen_frame.dart';

import '../models/department_member.dart';

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
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    title: Column(children: const <Widget>[Text('부서 해지')]),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[Text('${widget.departmentMember.userName}님을 해지하시겠습니까?')],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        child: Text('취소')
                      ),
                      TextButton(
                        child: Text('확인'), 
                        onPressed: () {
                          Navigator.pop(context);
                          widget.departmentMember.leave().then((bool result) {
                            if (result) {
                              Navigator.pop(context);
                            }
                            else {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    title: Column(children: const <Widget>[Text('부서 해지')]),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[Text("해지 처리 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('확인'), 
                                        onPressed: () {Navigator.pop(context);},
                                      )
                                    ],
                                  );
                                }
                              );
                            }
                          });
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                },
              );
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