import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import '../../models/position_request.dart';
import '../../widgets/title_text.dart';
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
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '직책 신청 정보',
            ),
            Expanded(
              flex: 2,
              child: Container(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Color.fromARGB(31, 0, 0, 0),
                ),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '이름',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.positionRequest.requestUserName,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '생년월일',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.positionRequest.requestUserBirthday,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '성별',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.positionRequest.requestUserSex == 'male' ? '남' : '여',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              '요청일시',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.positionRequest.requestDatetime.substring(0, 16),
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 26,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                '부서',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                widget.positionRequest.requestDepartmentName,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 26,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                '신청 직책',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                widget.positionRequest.requestPositionName,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    onPressed: () {
                      AppCore.showMessage(context, '직책 요청 거부', '${widget.positionRequest.requestUserName}님을 거부하시겠습니까?', ActionType.yesNo, () {
                        Navigator.pop(context);
                        widget.positionRequest.approvalStatus = 0;
                        widget.positionRequest.requestFinish().then((bool result) {
                          if (!result) {
                            AppCore.showMessage(context, '직책 신청 거부', '거부 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                              Navigator.pop(context);
                            });
                          }
                          else {
                            Navigator.pop(context, true);
                          }
                        });
                      });
                    },
                    child: Text(
                      '거부',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 90, 68, 223),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )
                    ),
                    onPressed: () {
                      AppCore.showMessage(context, '직책 요청 승인', '${widget.positionRequest.requestUserName}님을 승인하시겠습니까?', ActionType.yesNo, () {
                        Navigator.pop(context);
                        widget.positionRequest.approvalStatus = 2;
                        widget.positionRequest.requestFinish().then((bool result) {
                          if (!result) {
                            AppCore.showMessage(context, '직책 신청 승인', '승인 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                              Navigator.pop(context);
                            });
                          }
                          else{
                            Navigator.pop(context, true);
                          }
                        });
                      });
                    },
                    child: Text(
                      '승인',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}