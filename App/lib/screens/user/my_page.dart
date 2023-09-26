import 'package:flutter/material.dart';
import 'package:test/screens/department/department_leave.dart';
import 'package:test/screens/department/department_request.dart';
import 'package:test/screens/inquiry/inquiry_request.dart';
import 'package:test/screens/user/password_auth_check.dart';
import 'package:test/screens/position/position_request.dart';
import 'package:test/screens/screen_frame.dart';
import '../../app_core.dart';
import '../../models/department.dart';
import '../../models/position.dart';
import '../../widgets/title_text.dart';
import '../department/department_member_list.dart';
import '../department/department_request_list.dart';
import '../position/position_leave.dart';
import '../position/position_request_list.dart';
import '../inquiry/inquiry_list.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    List<Position> userPositionList = <Position>[];

    for (Department department in AppCore.instance.getUser().departmentList) {
      userPositionList.addAll(department.positionList);
    }

    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: '마이페이지',
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            AppCore.instance.getUser().userName.text,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          Text(
                            '님',
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                          )
                        ],
                      )
                    ),
                    Expanded(
                      flex: 3,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: userPositionList.length,
                        itemBuilder: (BuildContext context, int index) {
                          String positionName = userPositionList[index].positionName;

                          return Column(
                            children: [
                              Expanded(
                                flex: 2,
                                child: SizedBox(
                                ),
                              ),
                              Expanded(
                                flex: 3,
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(2, 0, 2, 10),
                                  padding: EdgeInsets.fromLTRB(8, 4, 8, 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    color: Color.fromARGB(236, 214, 215, 252),
                                  ),
                                  child: Text(
                                    positionName.isNotEmpty ? positionName : '없음',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                '개인정보 관리',
                style: TextStyle(
                  color: Color.fromARGB(255, 90, 68, 223),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text(
                  '개인정보 수정',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordAuthCheck(type: ScreenType.userInfoUpdate,)),);
                },
              ),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text(
                  '비밀번호 수정',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PasswordAuthCheck(type: ScreenType.passwordUpdate)),);
                },
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '부서 관리',
                style: TextStyle(
                  color: Color.fromARGB(255, 90, 68, 223),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text('부서 신청',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentRequest()),);
                },
              ),
              AppCore.authCheck('부서원 관리') ?
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text('부서원 관리',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentMemberList()),);
                },
              ) : SizedBox(),
              AppCore.authCheck('부서 승인') ?
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text('부서 승인',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentRequestList()),);
                },
              ) : SizedBox(),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text('부서 탈퇴',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentLeave()));
                },
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '직책 관리',
                style: TextStyle(
                  color: Color.fromARGB(255, 90, 68, 223),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text('직책 신청',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PositionRequest()));
                },
              ),
              AppCore.authCheck('직책 승인') ?
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text('직책 승인',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PositionRequestList()));
                },
              ) : SizedBox(),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text('직책 탈퇴',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PositionLeave()));
                },
              ),
              Divider(
                color: Colors.black,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                '기타관리',
                style: TextStyle(
                  color: Color.fromARGB(255, 90, 68, 223),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text('알림설정',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => PositionLeave()));
                },
              ),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text('문의하기',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InquiryRequest()));
                },
              ),
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text('문의내역',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => InquiryList()));
                },
              ),
            ]
          ),
        ),
      ),
    );
  }
}