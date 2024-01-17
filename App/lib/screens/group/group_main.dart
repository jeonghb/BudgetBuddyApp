import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test/screens/group/group_member_list.dart';

import '../../app_core.dart';
import '../../initialize.dart';
import '../../models/group.dart';
import '../../widgets/title_text.dart';
import '../../widgets/top_bar.dart';
import '../screen_frame.dart';
import 'group_add.dart';
import 'group_list.dart';
import 'my_group_list.dart';

class GroupMain extends StatefulWidget {
  const GroupMain({super.key});

  @override
  State<GroupMain> createState() => _GroupMain();
}

class _GroupMain extends State<GroupMain> {
  DateTime? curruentBackPressTime;
  Group selectGroup = Group();

  @override
  void initState() {
    super.initState();

    setState(() {
      selectGroup = AppCore.instance.getUser().selectGroup;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      appBarType: selectGroup.groupId != -1 ? BarType.main : BarType.invisible,
      body: WillPopScope(
        onWillPop: () async {
          DateTime now = DateTime.now();
          if (curruentBackPressTime == null || now.difference(curruentBackPressTime!) > Duration(seconds: 2)) {
            curruentBackPressTime = now;
            Fluttertoast.showToast(
              msg: "뒤로가기 버튼을 한번 더 누르면 종료됩니다",
            );
            return false;
          }
          return true;
        },
        child : Padding(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TitleText(
                  text: selectGroup.groupId == -1 ? '아직 소속된 그룹이 없어요!' : selectGroup.groupName,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: AppCore.instance.getUser().groupList.length > 1 ? Color.fromARGB(255, 90, 68, 223) : Colors.grey),
                        ),
                        height: 100,
                        child: InkWell(
                          onTap: () {
                            if (AppCore.instance.getUser().groupList.length <= 1) return;

                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyGroupList())).then((value) {
                              if (value) {
                                setState(() {
                                  selectGroup = AppCore.instance.getUser().selectGroup;
                                });
                              }
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/groupRegist.png',
                                color: AppCore.instance.getUser().groupList.length > 1 ? Color.fromARGB(255, 90, 68, 223) : Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '그룹 전환',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: selectGroup.groupMaster ? Color.fromARGB(255, 90, 68, 223) : Colors.grey),
                        ),
                        height: 100,
                        child: InkWell(
                          onTap: () {
                            if (!selectGroup.groupMaster) return;

                            Navigator.push(context, MaterialPageRoute(builder: (context) => GroupMemberList())).then((value) {
                              setState(() {
                                selectGroup = AppCore.instance.getUser().selectGroup;
                              });
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/groupAdd.png',
                                color: selectGroup.groupMaster ? Color.fromARGB(255, 90, 68, 223) : Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '그룹 관리자 변경',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Color.fromARGB(255, 90, 68, 223)),
                        ),
                        height: 100,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GroupList()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/groupRegist.png',
                                color: Color.fromARGB(255, 90, 68, 223),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '그룹 가입',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: Color.fromARGB(255, 90, 68, 223)),
                        ),
                        height: 100,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => GroupAdd()));
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/groupAdd.png',
                                color: Color.fromARGB(255, 90, 68, 223),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '그룹 생성',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: selectGroup.groupId != -1 ? Color.fromARGB(255, 90, 68, 223) : Colors.grey),
                        ),
                        height: 100,
                        child: InkWell(
                          onTap: () {
                            if (selectGroup.groupId == -1) return;

                            if (selectGroup.groupMaster) {
                              AppCore.showMessage(context, '그룹 탈퇴', '그룹관리자는 그룹을 탈퇴할 수 없습니다', ActionType.ok, () {
                                Navigator.pop(context);
                              });

                              return;
                            }

                            AppCore.showMessage(context, '그룹 탈퇴', '정말로 그룹을 탈퇴하시겠습니까?', ActionType.yesNo, () async {
                              Navigator.pop(context);

                              if (await selectGroup.groupExit()) {
                                // ignore: use_build_context_synchronously
                                AppCore.showMessage(context, '그룹 탈퇴', '그룹이 탈퇴되었습니다', ActionType.ok, () {
                                  Navigator.pop(context);
                                });

                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Initialize()), (route) => false,);
                              }
                              else {
                                // ignore: use_build_context_synchronously
                                AppCore.showMessage(context, '그룹 탈퇴', '그룹 탈퇴 실패', ActionType.ok, () {
                                  Navigator.pop(context);
                                });
                              }
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/groupRegist.png',
                                color: selectGroup.groupId != -1 ? Color.fromARGB(255, 90, 68, 223) : Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '그룹 탈퇴',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(color: selectGroup.groupMaster ? Color.fromARGB(255, 90, 68, 223) : Colors.grey),
                        ),
                        height: 100,
                        child: InkWell(
                          onTap: () {
                            if (!selectGroup.groupMaster) return;

                            AppCore.showMessage(context, '그룹 삭제', '정말로 그룹 ${selectGroup.groupName}을 삭제하시겠습니까? 삭제된 그룹은 되돌릴 수 없습니다', ActionType.yesNo, () async {
                              Navigator.pop(context);

                              if (await selectGroup.groupDelete()) {
                                // ignore: use_build_context_synchronously
                                AppCore.showMessage(context, '그룹 삭제', '그룹이 삭제되었습니다', ActionType.ok, () {
                                  Navigator.pop(context);
                                });

                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Initialize()), (route) => false,);
                              }
                              else {
                                // ignore: use_build_context_synchronously
                                AppCore.showMessage(context, '그룹 삭제', '삭제 실패', ActionType.ok, () {
                                  Navigator.pop(context);
                                });
                              }
                            });
                          },
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/groupRegist.png',
                                color: selectGroup.groupMaster ? Color.fromARGB(255, 90, 68, 223) : Colors.grey,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                '그룹 삭제',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}