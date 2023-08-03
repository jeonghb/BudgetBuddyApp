import 'dart:convert';

import 'package:flutter/material.dart';
import '../app_core.dart';
import '../models/response_data.dart';
import 'screen_frame.dart';
import '../models/department.dart';

class DepartmentRequest extends StatefulWidget {
  const DepartmentRequest({super.key});

  @override
  State<DepartmentRequest> createState() => _DepartmentRequest();
}

class _DepartmentRequest extends State<DepartmentRequest> {
  int selectDepartmentId = -1;
  String selectDepartmentName = '';
  List<Department> departmentList = <Department>[];

  @override
  void initState() {
    super.initState();

    departmentList.add(Department());
  
    getDepartmentList();
  }

  void getDepartmentList() async {
    String address = '/getDepartmentList';
    Map<String, String> body = {
    };

    ResponseData responseData = await AppCore.request(ServerType.GET, address, body);

    if (responseData.statusCode == 200) {
      List<Department> tempList = <Department>[];
      tempList.add(Department());
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
    int selectIndex = 0;

    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              '부서 신청',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // ListView.builder(
            //   physics: ScrollPhysics(),
            //   shrinkWrap: true,
            //   itemCount: departmentList.length,
            //   itemBuilder: (BuildContext context, int index) {
            //     final department = departmentList[index];

            //     return GestureDetector(
            //       onTap: () {
            //         selectIndex = departmentList.indexWhere((element) => element == department);
            //       },
            //       child: Column(
            //         children: [
            //           ListTile(
            //             leading: Text(department.departmentName),
            //           )
            //         ],
            //       ),
            //     );
            //   },
            // ),
            DropdownButton(
              isExpanded: true,
              value: selectDepartmentName,
              items: departmentList.map(
                (value) { 
                  return DropdownMenuItem<String>(
                    value: value.departmentName,
                    child: Text(value.departmentName),
                    );
                  },
                ).toList(),
              onChanged: (value) {
                setState(() {
                  selectDepartmentId = departmentList.firstWhere((department) => department.departmentName == value).departmentId;
                  selectDepartmentName = departmentList.firstWhere((department) => department.departmentName == value).departmentName;
                });
              }
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 90, 68, 223)),
              ),
              onPressed: () async {
                if (await departmentRequest(selectDepartmentId)) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        title: Column(children: const <Widget>[Text('부서 신청')]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[Text("요청 완료",),],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('확인'), 
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                }
                else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        title: Column(children: const <Widget>[Text('부서 신청')]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[Text("요청에 실패했습니다.",),],
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('확인'), 
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ],
                      );
                    },
                  );
                }
              },
              child: Text(
                '신청',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ),
          ],
        )
      )
    );
  }
}

Future<bool> departmentRequest(int selectDepartmentId) async {
  String address = '/departmentRequest';
  Map<String, dynamic> body = {
    'userId' : AppCore.instance.getUser().userId.text,
    'departmentId' : selectDepartmentId,
  };

  ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

  if (responseData.statusCode == 200) {
    if (responseData.body.toString() == 'true') {
      return true;
    }
    else {
      return false;
    }
  }
  else {
    return false;
  }
}