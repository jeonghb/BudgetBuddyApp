import 'package:flutter/material.dart';
import 'package:test/app_core.dart';

import '../models/response_data.dart';
import 'screen_frame.dart';

class DepartmentLeave extends StatefulWidget {
  const DepartmentLeave({super.key});

  @override
  State<DepartmentLeave> createState() => _DepartmentLeave();
}

class _DepartmentLeave extends State<DepartmentLeave> {
  int selectDepartmentId = -1;
  
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '부서 탈퇴',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          DropdownButton(
            isExpanded: true,
            value: AppCore.instance.getUser().departmentList,
            items: AppCore.instance.getUser().departmentList.map(
              (value) { 
                return DropdownMenuItem<String>(
                  value: value.departmentName,
                  child: Text(value.departmentName),
                  );
                },
              ).toList(),
            onChanged: (value) {
              setState(() {
                selectDepartmentId = AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentName == value).departmentId;
              });
            }
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    title: Column(children: const <Widget>[Text('부서 탈퇴')]),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[Text('선택한 부서를 탈퇴하시겠습니까?'),],
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        }, 
                        child: Text('취소')
                      ),
                      TextButton(
                        child: Text('확인'), 
                        onPressed: () {
                          Navigator.pop(context);
                          leave(selectDepartmentId).then((bool result) {
                            if (result) {
                              Navigator.pop(context);
                            }
                            else {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    title: Column(children: const <Widget>[Text('부서 해지')]),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[Text("해지 처리 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('확인'), 
                                        onPressed: () {Navigator.pop(context);},
                                      )
                                    ],
                                  );
                                }
                              );
                            }
                          });
                          Navigator.pop(context);
                        },
                      )
                    ],
                  );
                },
              );
            },
            child: Text(
              '부서 탈퇴',
            ),
          ),
        ]
      )
    );
  }
}

Future<bool> leave(int selectDepartmentId) async {
  String address = '/DepartmentLeave';
  Map<String, String> body = {
    'userId': AppCore.instance.getUser().userId.text,
    'departmentId': selectDepartmentId.toString(),
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