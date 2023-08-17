import 'dart:convert';

import 'package:flutter/material.dart';

import '../../app_core.dart';
import '../../models/department.dart';
import '../../models/response_data.dart';
import '../screen_frame.dart';
import 'department_manage.dart';

class DepartmentList extends StatefulWidget {
  const DepartmentList({super.key});

  @override
  State<DepartmentList> createState() => _DepartmentList();
}

class _DepartmentList extends State<DepartmentList> {
  List<Department> departmentList = <Department>[];

  @override
  void initState() {
    super.initState();

    getDepartmentList();
  }

  void getDepartmentList() async {
    String address = '/getDepartmentList';
    Map<String, dynamic> body = {
    };

    ResponseData responseData = await AppCore.request(ServerType.GET, address, body);

    if (responseData.statusCode == 200) {
      List<Department> tempList = <Department>[];
      
      for (var json in jsonDecode(responseData.body))
      {
        Department department = Department();
        department.setData(json);

        tempList.add(department);
      }

      setState(() {
        departmentList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '부서 목록',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: departmentList.length,
            itemBuilder: (BuildContext context, int index) {
              final department = departmentList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentManage(department: department,)),).then((value) {
                    if (value == true) {
                      getDepartmentList();
                    }
                  });
                },
                child: Column (
                  children: [
                    ListTile(
                      leading: Text(department.departmentName),
                      
                    ),
                    Divider(),
                  ]
                ),
              );
            }
          )
        ]
      ),
    );
  }
}