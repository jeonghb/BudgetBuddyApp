import 'package:flutter/material.dart';

import '../app_core.dart';
import '../models/response_data.dart';
import 'screen_frame.dart';

class PositionLeave extends StatefulWidget {
  const PositionLeave({super.key});

  @override
  State<PositionLeave> createState() => _PositionLeave();
}

class _PositionLeave extends State<PositionLeave> {
  int selectDepartmentId = -1;
  int selectPositionId = -1;

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '직책 탈퇴',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '부서'
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButton(
            isExpanded: true,
            value: AppCore.instance.getUser().departmentList[0].departmentName,
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
          SizedBox(
            height: 20,
          ),
          Text(
            '직책',
          ),
          SizedBox(
            height: 20,
          ),
          DropdownButton(
            isExpanded: true,
            value: AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList[0].positionName,
            items: AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.map(
              (value) { 
                return DropdownMenuItem<String>(
                  value: value.positionName,
                  child: Text(value.positionName),
                  );
                },
              ).toList(),
            onChanged: (value) {
              setState(() {
                selectPositionId = AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.positionName == value).positionId;
              });
            }
          ),
          SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    title: Column(children: const <Widget>[Text('직책 탈퇴')]),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[Text('선택한 직책을 탈퇴하시겠습니까?'),],
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
                          leave(selectDepartmentId, selectPositionId).then((bool result) {
                            if (result) {
                              Navigator.pop(context);
                            }
                            else {
                              showDialog(
                                context: context, 
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    title: Column(children: const <Widget>[Text('직책 탈퇴')]),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: const <Widget>[Text("탈퇴 처리 중 오류가 발생하였습니다. 다시 시도해주세요.",),],
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
              '직책 탈퇴',
            ),
          ),
        ]
      )
    );
  }
}

Future<bool> leave(int selectDepartmentId, int selectPositionId) async {
  String address = '/PositionLeave';
  Map<String, String> body = {
    'userId': AppCore.instance.getUser().userId.text,
    'departmentId': selectDepartmentId.toString(),
    'positionId' : selectPositionId.toString(),
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