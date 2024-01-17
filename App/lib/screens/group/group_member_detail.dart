import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/models/group_member.dart';

import '../../initialize.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class GroupMemberDetail extends StatefulWidget {
  final GroupMember groupMember;

  const GroupMemberDetail({
    super.key,
    required this.groupMember,
  });

  @override
  State<GroupMemberDetail> createState() => _GroupMemberDetail();
}

class _GroupMemberDetail extends State<GroupMemberDetail> {
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '그룹원 정보',
            ),
            Expanded(
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
                              widget.groupMember.userName,
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
                              widget.groupMember.userBirthday,
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
                              widget.groupMember.userSex == 'male' ? '남' : '여',
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
                      // Row(
                      //   children: [
                      //     Expanded(
                      //       child: Text(
                      //         '그룹 가입일',
                      //         style: TextStyle(
                      //           fontSize: 16,
                      //           color: Colors.grey[600],
                      //         ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Text(
                      //         widget.groupMember.
                      //         style: TextStyle(
                      //           fontSize: 18,
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Divider(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              )
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(130),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 90, 68, 223)),
                ),
                onPressed: () {
                  AppCore.showMessage(context, '관리자 변경', '${widget.groupMember.userName}님을 관리자로 변경하시겠습니까?', ActionType.yesNo, () async {
                    Navigator.pop(context);

                    if (await widget.groupMember.groupManagerUpdate()) {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '관리자 변경', '관리자가 변경되었습니다', ActionType.ok, () {
                        Navigator.pop(context);

                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Initialize()), (route) => false,);
                      });
                    }
                    else {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '관리자 변경', '관리자 변경 실패', ActionType.ok, () {
                        Navigator.pop(context);
                      });
                    }
                  });
                },
                child: Text(
                  '관리자 변경',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ),
            ),
          ]
        ),
      ),
    );
  }
}