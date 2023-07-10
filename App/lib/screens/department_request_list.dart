import 'package:flutter/material.dart';

import '../models/department_request.dart';
import 'department_request_manage.dart';
import 'screen_frame.dart';

class DepartmentRequestList extends StatefulWidget {
  const DepartmentRequestList({super.key});

  @override
  State<DepartmentRequestList> createState() => _DepartmentRequestList();
}

class _DepartmentRequestList extends State<DepartmentRequestList> {
  List<DepartmentRequest> departmentRequestList = <DepartmentRequest>[];

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '부서 신청 목록',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: departmentRequestList.length,
            itemBuilder: (BuildContext context, int index) {
              final departmentRequest = departmentRequestList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentRequestManage(departmentRequest: departmentRequest,)),);
                },
                child: Column (
                  children: [
                    ListTile(
                      leading: Text(departmentRequest.requestUserName),
                      
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