import 'package:flutter/material.dart';

import '../../app_core.dart';
import '../../widgets/title_text.dart';
import '../department/department_add.dart';
import '../department/department_list.dart';
import '../position/position_add.dart';
import '../position/position_list.dart';
import '../screen_frame.dart';

class AuthManage extends StatefulWidget {
  const AuthManage({super.key});

  @override
  State<AuthManage> createState() => _AuthManage();
}

class _AuthManage extends State<AuthManage> {
  @override
  Widget build(BuildContext context) {

    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: '권한 관리',
              ),
              Text(
                '부서 관리',
                style: TextStyle(
                  color: Color.fromARGB(255, 90, 68, 223),
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppCore.authCheck('부서 추가') ?
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text(
                  '부서 추가',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentAdd()),);
                },
              ) : SizedBox(),
              AppCore.authCheck('부서 수정') ?
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text(
                  '부서 수정',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentList()),);
                },
              ) : SizedBox(),
              Text(
                '직책 관리',
                style: TextStyle(
                  color: Color.fromARGB(255, 90, 68, 223),
                  fontWeight: FontWeight.bold,
                ),
              ),
              AppCore.authCheck('직책 추가') ?
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text(
                  '직책 추가',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PositionAdd()),);
                },
              ) : SizedBox(),
              AppCore.authCheck('직책 수정') ?
              ListTile(
                trailing: Icon(Icons.keyboard_arrow_right),
                iconColor: Colors.black,
                title: Text(
                  '직책 수정',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PositionList()),);
                },
              ) : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}