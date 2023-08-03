import 'dart:convert';
import 'package:flutter/material.dart';
import 'screen_frame.dart';
import '../app_core.dart';
import '../models/department_member.dart';
import '../models/response_data.dart';
import 'department_member_manage.dart';

class DepartmentMemberList extends StatefulWidget {
  const DepartmentMemberList({super.key});

  @override
  State<DepartmentMemberList> createState() => _DepartmentMemberList();
}

class _DepartmentMemberList extends State<DepartmentMemberList> {
  List<DepartmentMember> departmentMemberList = <DepartmentMember>[];

  @override
  void initState() {
    super.initState();

    getDepartmentMemberList();
  }
  
  Future<void> getDepartmentMemberList() async {
    String address = '/getDepartmentMemberList';
    Map<String, String> body = {
      'userId': AppCore.instance.getUser().userId.text,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      List<DepartmentMember> tempList = <DepartmentMember>[];

      for (Map<String, dynamic> json in json.decode(responseData.body)) {
        DepartmentMember departmentMember = DepartmentMember();
        departmentMember.fromJson(json);
        tempList.add(departmentMember);
      }

      setState(() {
        departmentMemberList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '부서원 목록',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: departmentMemberList.length,
            itemBuilder: (BuildContext context, int index) {
              final departmentMember = departmentMemberList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentMemberManage(departmentMember: departmentMember,)),);
                },
                child: Column (
                  children: [
                    ListTile(
                      leading: Text(departmentMember.userName),
                    ),
                    Divider(),
                  ]
                ),
              );
            }
          )
        ],
      )
    );
  }
}