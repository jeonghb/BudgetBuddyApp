import 'package:flutter/material.dart';
import 'package:test/screens/department_request.dart';
import 'package:test/screens/password_auth_check.dart';
import 'package:test/screens/screen_frame.dart';

import '../app_core.dart';
import 'department_member_list.dart';

class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    List<ExpansionTile> menuList = [
      ExpansionTile(
        title: Text(
          '개인정보 관리',
        ),
        children: [
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            iconColor: Color.fromARGB(255, 90, 68, 223),
            focusColor: Color.fromARGB(255, 90, 68, 223),
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
            leading: Icon(Icons.add_box_outlined),
            iconColor: Color.fromARGB(255, 90, 68, 223),
            focusColor: Color.fromARGB(255, 90, 68, 223),
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
        ],
      ),
      ExpansionTile(
        title: Text(
          '부서 관리',
        ),
        children: [
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            iconColor: Color.fromARGB(255, 90, 68, 223),
            focusColor: Color.fromARGB(255, 90, 68, 223),
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
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            iconColor: Color.fromARGB(255, 90, 68, 223),
            focusColor: Color.fromARGB(255, 90, 68, 223),
            title: Text('부서원 관리',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentMemberList()),);
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            iconColor: Color.fromARGB(255, 90, 68, 223),
            focusColor: Color.fromARGB(255, 90, 68, 223),
            title: Text('부서 승인',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            onTap: () {
              
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            iconColor: Color.fromARGB(255, 90, 68, 223),
            focusColor: Color.fromARGB(255, 90, 68, 223),
            title: Text('부서 탈퇴',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            onTap: () {
              
            },
          ),
        ],
      ),
      ExpansionTile(
        title: Text(
          '직책 관리',
        ),
        children: [
          ListTile(
            leading: Icon(Icons.add_box_outlined),
            iconColor: Color.fromARGB(255, 90, 68, 223),
            focusColor: Color.fromARGB(255, 90, 68, 223),
            title: Text('직책 신청',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            onTap: () {
              
            },
          ),
        ],
      ),
    ];

    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '마이페이지',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
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
                    width: 10,
                  ),
                  Text(
                    AppCore.instance.getUser().userName.text,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '',
                    // AppCore.instance.getUser().departmentId.toString(), // 이거 부서 + 직책 넣어야할듯
                    style: TextStyle(
                      backgroundColor: Colors.green[100],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return menuList[index];
                }
              ),
            ),
          ]
        ),
      ),
    );
  }
}