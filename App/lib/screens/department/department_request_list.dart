import 'dart:convert';
import 'package:flutter/material.dart';
import '../../app_core.dart';
import '../../models/department_request.dart';
import '../../models/response_data.dart';
import 'department_request_manage.dart';
import '../screen_frame.dart';

class DepartmentRequestList extends StatefulWidget {
  const DepartmentRequestList({super.key});

  @override
  State<DepartmentRequestList> createState() => _DepartmentRequestList();
}

class _DepartmentRequestList extends State<DepartmentRequestList> {
  List<DepartmentRequest> departmentRequestList = <DepartmentRequest>[];

  @override
  void initState() {
    super.initState();

    departmentRequestList.add(DepartmentRequest());

    getDepartmentRequestList();
  }

  void getDepartmentRequestList() async {
    String address = '/getDepartmentRequestList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId.text,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      List<DepartmentRequest> tempList = <DepartmentRequest>[];
      
      for (var json in jsonDecode(responseData.body))
      {
        DepartmentRequest departmentRequest = DepartmentRequest();
        departmentRequest.setData(json);

        tempList.add(departmentRequest);
      }

      setState(() {
        departmentRequestList = tempList;
      });
    }
  }

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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DepartmentRequestManage(departmentRequest: departmentRequest,)),).then((value) {
                    if (value == true) {
                      getDepartmentRequestList();
                    }
                  });
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