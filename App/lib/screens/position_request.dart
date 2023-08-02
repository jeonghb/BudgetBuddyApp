import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../app_core.dart';
import '../models/Position.dart';
import '../models/department.dart';
import '../models/response_data.dart';
import 'screen_frame.dart';

class PositionRequest extends StatefulWidget {
  const PositionRequest({super.key});

  @override
  State<PositionRequest> createState() => _PositionRequest();
}

class _PositionRequest extends State<PositionRequest> {
  List<Department> departmentList = <Department>[];
  int selectPositiontId = -1;
  int selectDepartmentId = -1;

  @override
  void initState() {
    super.initState();

    getDepartmentList();
    getPositionList();
  }

  void getDepartmentList() async {
    Uri uri = Uri.parse('${AppCore.baseUrl}/getDepartmentList');

    http.Response response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    for (var json in jsonDecode(response.body))
    {
      Department department = Department();
      department.setData(json);

      // 본인이 소속된 부서만 리스트업
      if (AppCore.instance.getUser().departmentList.where((element) => element.departmentId == department.departmentId).isNotEmpty) {
        departmentList.add(department);
      }
    }
  }

  void getPositionList() async {
    Uri uri = Uri.parse('${AppCore.baseUrl}/getPositionList');

    http.Response response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    for (var json in jsonDecode(response.body))
    {
      Position position = Position();
      position.setData(json);

      // 본인이 소속된 부서에 직책 연결
      // Department department = AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == position.departmentId);

      // if (department == null) {
      //   return;
      // }

      // department.positionList.add(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '직책 신청',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '부서',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
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
          SizedBox(
            height: 20,
          ),
          Text(
            '직책',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButton(
            isExpanded: true,
            value: departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList[0].positionName,
            items: departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.map(
              (value) { 
                return DropdownMenuItem<String>(
                  value: value.positionName,
                  child: Text(value.positionName),
                  );
                },
              ).toList(),
            onChanged: (value) {
              setState(() {
                selectPositiontId = departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.positionName == value).positionId;
              });
            }
          ),
          SizedBox(
            height: 30,
          ),
          TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 90, 68, 223)),
            ),
            onPressed: () async {
              if (await positionRequest(selectDepartmentId, selectPositiontId)) {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      title: Column(children: const <Widget>[Text('직책 신청')]),
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
        ]
      )
    );
  }
}

Future<bool> positionRequest(int selectDepartmentId, int selectPositiontId) async {
  String address = '/positionRequest';
  Map<String, dynamic> body = {
    'userId' : AppCore.instance.getUser().userId.text,
    'departmentId' : selectDepartmentId,
    'positionId' : selectPositiontId,
  };

  ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

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