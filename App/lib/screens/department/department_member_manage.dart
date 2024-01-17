import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/screen_frame.dart';

import '../../models/department_member.dart';
import '../../widgets/title_text.dart';

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
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '부서원 정보',
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
                              widget.departmentMember.userName,
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
                              widget.departmentMember.userBirthday,
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
                              widget.departmentMember.userSexName,
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
                              '부서 가입일',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              widget.departmentMember.userDepartmentRegistDatetime.substring(0, 10),
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
                              flex: 3,
                              child: Text(
                                widget.departmentMember.userDepartmentName,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  if (widget.departmentMember.userId == AppCore.instance.getUser().userId) return;

                                  AppCore.showMessage(context, '부서 해지', '${widget.departmentMember.userName}님을 해지하시겠습니까?', ActionType.yesNo, () {
                                    widget.departmentMember.departmentLeave().then((bool result) {
                                      if (result) {
                                        Navigator.pop(context);
                                      }
                                      else {
                                        AppCore.showMessage(context, '부서 해지', '해지 처리 중 오류가 발생하였습니다. 다시 시도해주세요', ActionType.ok, () {
                                          Navigator.pop(context);
                                        });
                                      }
                                    });
                                    Navigator.pop(context);
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: widget.departmentMember.userId != AppCore.instance.getUser().userId ? Colors.black : Colors.grey,
                                  padding: EdgeInsets.all(0),
                                ),
                                child: Text(
                                  '탈퇴',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white
                                  ),
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
                                '직책',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(
                                widget.departmentMember.userPositionName.isNotEmpty ? widget.departmentMember.userPositionName : '없음',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Expanded(
                              child: widget.departmentMember.userPositionId != -1 ? TextButton(
                                onPressed: () {
                                  AppCore.showMessage(context, '직책 해지', '${widget.departmentMember.userName}님을 해지하시겠습니까?', ActionType.yesNo, () {
                                    widget.departmentMember.positionLeave().then((bool result) {
                                      if (result) {
                                        Navigator.pop(context);
                                      }
                                      else {
                                        AppCore.showMessage(context, '직책 해지', '해지 처리 중 오류가 발생하였습니다. 다시 시도해주세요', ActionType.ok, () {
                                          Navigator.pop(context);
                                        });
                                      }
                                    });
                                    Navigator.pop(context);
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  padding: EdgeInsets.all(0),
                                ),
                                child: Text(
                                    '탈퇴',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white
                                    ),
                                ),
                              ) : SizedBox(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ),
            Expanded(
              child: SizedBox(),
            ),
          ],
        )
      ),
    );
  }
}