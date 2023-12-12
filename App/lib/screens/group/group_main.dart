import 'package:flutter/material.dart';

import '../../app_core.dart';
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
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      appBarType: AppCore.instance.getUser().selectGroupId != -1 ? BarType.exit : BarType.invisible,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TitleText(
              text: AppCore.instance.getUser().selectGroupId == -1 ? '아직 소속된 그룹이 없어요!' : '그룹관리',
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
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MyGroupList()));
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/groupRegist.png',
                            color: Color.fromARGB(255, 90, 68, 223),
                          ),
                          Text(
                            '그룹 전환',
                          )
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
                          Text(
                            '그룹 가입',
                          )
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
                          Text(
                            '그룹 생성',
                          )
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
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/groupRegist.png',
                            color: Color.fromARGB(255, 90, 68, 223),
                          ),
                          Text(
                            '그룹 탈퇴',
                          )
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
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/groupRegist.png',
                            color: Color.fromARGB(255, 90, 68, 223),
                          ),
                          Text(
                            '그룹 삭제',
                          )
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
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.circular(10.0),
                    //   border: Border.all(color: Color.fromARGB(255, 90, 68, 223)),
                    // ),
                    height: 100,
                    // child: InkWell(
                    //   onTap: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => GroupAdd()));
                    //   },
                    //   child: Column(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Image.asset(
                    //         'assets/images/groupAdd.png',
                    //         color: Color.fromARGB(255, 90, 68, 223),
                    //       ),
                    //       Text(
                    //         '그룹 생성',
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}