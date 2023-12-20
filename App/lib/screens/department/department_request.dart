import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app_core.dart';
import '../../models/response_data.dart';
import '../../widgets/dropdown_button_v1.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';
import '../../models/department.dart';

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
    String address = '/getRequestPositilityDepartmentList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

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

  Future<bool> departmentRequest(int selectDepartmentId) async {
    String address = '/departmentRequest';
    Map<String, dynamic> body = {
      'userId' : AppCore.instance.getUser().userId,
      'departmentId' : selectDepartmentId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

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
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TitleText(
              text: '부서 신청',
            ),
            DropdownButtonV1(
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
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(130),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 90, 68, 223)),
                ),
                onPressed: () async {
                  if (selectDepartmentId == -1) {
                    AppCore.showMessage(context, '부서 신청', '신청할 부서를 선택하세요.', ActionType.ok, () {
                      Navigator.pop(context);
                    });
                    
                    return;
                  }
                  else if (await departmentRequest(selectDepartmentId)) {
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '부서 신청', '요청 완료', ActionType.ok, () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  }
                  else {
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '부서 신청', '요청에 실패했습니다.', ActionType.ok, () {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text(
                  '신청',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ),
            ),
          ],
        )
      )
    );
  }
}