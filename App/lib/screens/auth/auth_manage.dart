import 'package:flutter/material.dart';

import '../../app_core.dart';
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
    List<ExpansionTile> menuList = [];
    List<ListTile> listTileList = <ListTile>[];
    if (AppCore.authCheck('부서 추가')) {
      listTileList.add(
        ListTile(
          leading: Icon(Icons.add_box_outlined),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
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
        ),
      );
    }
    if (AppCore.authCheck('부서 수정')) {
      listTileList.add(
        ListTile(
          leading: Icon(Icons.add_box_outlined),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
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
        ),
      );
    }
    if (listTileList.isNotEmpty) {
      menuList.add(
        ExpansionTile(
          title: Text(
            '부서 관리',
          ),
          children: listTileList,
        )
      );
    }
    listTileList = <ListTile>[];
    if (AppCore.authCheck('직책 추가')) {
      listTileList.add(
        ListTile(
          leading: Icon(Icons.add_box_outlined),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
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
        ),
      );
    }
    if (AppCore.authCheck('직책 수정')) {
      listTileList.add(
        ListTile(
          leading: Icon(Icons.add_box_outlined),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
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
        ),
      );
    }
    if (listTileList.isNotEmpty) {
      menuList.add(
        ExpansionTile(
          title: Text(
            '직책 관리',
          ),
          children: listTileList,
        )
      );
    }

    return ScreenFrame(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              '권한 관리',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: menuList.length,
                itemBuilder: (context, index) {
                  return menuList[index];
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}