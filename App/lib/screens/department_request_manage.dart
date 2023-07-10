import 'package:flutter/material.dart';

import '../models/department_request.dart';
import 'screen_frame.dart';

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
          Text(
            '부서 신청 정보',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
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
                widget.departmentRequest.requestUserBirthDay,
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
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        title: Column(children: const <Widget>[Text('부서 요청 거부')]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[Text('${widget.departmentRequest.requestUserName}님을 거부하시겠습니까?')],
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
                              widget.departmentRequest.requestResult = false;
                              widget.departmentRequest.requestFinish().then((bool result) {
                                if (result) {
                                  Navigator.pop(context);
                                }
                                else {
                                  showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        title: Column(children: const <Widget>[Text('부서 신청 거부')]),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const <Widget>[Text("거부 처리 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
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
                  '거부'
                ),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        title: Column(children: const <Widget>[Text('부서 요청 승인')]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[Text('${widget.departmentRequest.requestUserName}님을 승인하시겠습니까?')],
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
                              widget.departmentRequest.requestResult = true;
                              widget.departmentRequest.requestFinish().then((bool result) {
                                if (result) {
                                  Navigator.pop(context);
                                }
                                else {
                                  showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        title: Column(children: const <Widget>[Text('부서 신청 승인')]),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const <Widget>[Text("승인 처리 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
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
                    }
                  );
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