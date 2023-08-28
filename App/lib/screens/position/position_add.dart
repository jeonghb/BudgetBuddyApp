import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/widgets/text_form_field_v1.dart';

import '../../app_core.dart';
import '../../models/department.dart';
import '../../models/response_data.dart';
import '../screen_frame.dart';

class PositionAdd extends StatefulWidget {
  const PositionAdd({super.key});

  @override
  State<PositionAdd> createState() => _PositionAdd();
}

class _PositionAdd extends State<PositionAdd> {
  int selectDepartmentId = -1;
  String selectDepartmentName = '';
  List<Department> departmentList = <Department>[];
  TextEditingController positionName = TextEditingController();

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

  String setData() {
    if (selectDepartmentId == -1) {
      return '부서가 선택되지 않았습니다.';
    }
    else if (positionName.text.isEmpty) {
      return '직책명이 입력되지 않았습니다.';
    }

    return '';
  }

  Future<bool> positionAdd() async {
    String address = '/positionAdd';
    Map<String, dynamic> body = {
      'departmentId': selectDepartmentId,
      'positionName' : positionName.text,
      'authFlag': 0,
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

  @override
  Widget build(BuildContext context) {

    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '직책 추가',
          ),
          Text(
            '부서 선택',
          ),
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
          Text(
            '직책명'
          ),
          TextFormFieldV1(
            controller: positionName,
          ),
          TextButton(
            onPressed: () async {
              String validationMessage = setData();
              if (validationMessage.isEmpty) {
                if (await positionAdd()) {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '직책 추가', '직책 추가 완료', ActionType.ok, () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                }
                else {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '직책 추가', '직책 추가 실패. 해당 직책명이 추가되어 있는지 확인하세요.', ActionType.ok, () {
                    Navigator.pop(context);
                  });
                }
              }
              else {
                // ignore: use_build_context_synchronously
                AppCore.showMessage(context, '직책 추가', validationMessage, ActionType.ok, () {
                  Navigator.pop(context);
                });
              }
            },
            child: Text(
              '추가',
            ),
          ),
        ],
      ),
    );
  }
}