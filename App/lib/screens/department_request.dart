import 'dart:convert';

import 'package:flutter/material.dart';
import '../app_core.dart';
import '../models/response_data.dart';
import 'screen_frame.dart';
import '../models/department.dart';
import 'package:http/http.dart' as http;

class DepartmentRequest extends StatefulWidget {
  const DepartmentRequest({super.key});

  @override
  State<DepartmentRequest> createState() => _DepartmentRequest();
}

class _DepartmentRequest extends State<DepartmentRequest> {
  List<Department> departmentList = <Department>[];
  int selectDepartmentId = -1;

  @override
  void initState() {
    super.initState();

    getDepartmentList();
  }

  void getDepartmentList() async {
    Uri uri = Uri.parse('${AppCore.baseUrl}/getDepartmentList');

    http.Response response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    departmentList.add(Department());

    for (var json in jsonDecode(response.body))
    {
      Department department = Department();
      department.setData(json);

      // 해당 부서 소속이 아닌 것만 리스트업
      if (AppCore.instance.getUser().departmentList.where((element) => element.departmentId == department.departmentId).isEmpty) {
        departmentList.add(department);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
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
          DropdownButton(
            isExpanded: true,
            value: departmentList[0].departmentName,
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
    );
  }
}

Future<bool> departmentRequest(int selectDepartmentId) async {
  String address = '/departmentRequest';
  Map<String, dynamic> body = {
    'userId' : AppCore.instance.getUser().userId.text,
    'departmentId' : selectDepartmentId,
  };

  ResponseData responseData = await AppCore.request(address, body);

  if (responseData.statusCode == 200) {
    if (responseData.body == '1') {
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