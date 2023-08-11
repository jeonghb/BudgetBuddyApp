import 'package:flutter/material.dart';
import '../../models/position_request.dart';
import '../screen_frame.dart';

class PositionRequestManage extends StatefulWidget {
  final PositionRequest positionRequest;

  const PositionRequestManage({super.key, required this.positionRequest});

  @override
  State<PositionRequestManage> createState() => _PositionRequestManage();
}

class _PositionRequestManage extends State<PositionRequestManage> {
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '직책 신청 정보',
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
                widget.positionRequest.requestUserName,
              )
            ],
          ),
          Row(
            children: [
              Text(
                '생년월일',
              ),
              Text(
                widget.positionRequest.requestUserBirthday,
              )
            ],
          ),
          Row(
            children: [
              Text(
                '성별',
              ),
              Text(
                widget.positionRequest.requestUserSex,
              )
            ],
          ),
          Row(
            children: [
              Text(
                '신청부서',
              ),
              Text(
                widget.positionRequest.requestDepartmentName,
              )
            ],
          ),
          Row(
            children: [
              Text(
                '신청직책',
              ),
              Text(
                widget.positionRequest.requestPositionName,
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
                        title: Column(children: const <Widget>[Text('직책 요청 거부')]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[Text('${widget.positionRequest.requestUserName}님을 거부하시겠습니까?')],
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
                              widget.positionRequest.approvalStatus = 0;
                              widget.positionRequest.requestFinish().then((bool result) {
                                if (!result) {
                                  showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        title: Column(children: const <Widget>[Text('직책 신청 거부')]),
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
                              Navigator.pop(context, true);
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
                        title: Column(children: const <Widget>[Text('직책 요청 승인')]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[Text('${widget.positionRequest.requestUserName}님을 승인하시겠습니까?')],
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
                              widget.positionRequest.approvalStatus = 2;
                              widget.positionRequest.requestFinish().then((bool result) {
                                if (!result) {
                                  showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        title: Column(children: const <Widget>[Text('직책 신청 승인')]),
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
                              Navigator.pop(context, true);
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