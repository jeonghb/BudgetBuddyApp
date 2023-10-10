import 'dart:convert';

import 'package:flutter/material.dart';

import '../../app_core.dart';
import '../../models/department.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';
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
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '부서 목록',
            ),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: departmentList.length,
              itemBuilder: (BuildContext context, int index) {
                final department = departmentList[index];

                return GestureDetector(
                  onTap: () async {
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentManage(department: department,)),);
                    
                    getDepartmentList();
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
      ),
    );
  }
}