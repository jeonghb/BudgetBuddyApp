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
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '부서 신청 정보',
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
                              widget.departmentRequest.requestUserName,
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
                              widget.departmentRequest.requestUserBirthday,
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
                              widget.departmentRequest.requestUserSex == 'male' ? '남' : '여',
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
                              widget.departmentRequest.requestDatetime.substring(0, 16),
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
                                '신청 부서',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                widget.departmentRequest.requestDepartmentName,
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
                      AppCore.showMessage(context, '부서 요청 거부', '${widget.departmentRequest.requestUserName}님을 거부하시겠습니까?', ActionType.yesNo, () {
                        Navigator.pop(context);
                        widget.departmentRequest.approvalStatus = 0;
                        widget.departmentRequest.requestFinish().then((bool result) {
                          if (!result) {
                            AppCore.showMessage(context, '부서 신청 거부', '거부 처리 중 오류가 발생하였습니다. 다시 시도해주세요', ActionType.ok, () {
                              Navigator.pop(context);
                            });
                          }
                        });
                        Navigator.pop(context, true);
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
                      AppCore.showMessage(context, '부서 요청 승인', '${widget.departmentRequest.requestUserName}님을 승인하시겠습니까?', ActionType.yesNo, () {
                        Navigator.pop(context);
                        widget.departmentRequest.approvalStatus = 2;
                        widget.departmentRequest.requestFinish().then((bool result) {
                          if (!result) {
                            AppCore.showMessage(context, '부서 신청 승인', '승인 처리 중 오류가 발생하였습니다. 다시 시도해주세요', ActionType.ok, () {
                              Navigator.pop(context);
                            });
                          }
                        });
                        Navigator.pop(context, true);
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