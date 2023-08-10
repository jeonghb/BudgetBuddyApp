import 'package:flutter/material.dart';
import '../../app_core.dart';
import '../../models/response_data.dart';
import '../screen_frame.dart';

class PositionLeave extends StatefulWidget {
  const PositionLeave({super.key});

  @override
  State<PositionLeave> createState() => _PositionLeave();
}

class _PositionLeave extends State<PositionLeave> {
  int selectDepartmentId = AppCore.instance.getUser().departmentList[0].departmentId;
  String selectDepartmentName = '';
  int selectPositionId = -1;
  String selectPositionName = '';

  @override
  void initState() {
    super.initState();

    if (AppCore.instance.getUser().departmentList.isEmpty) {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(children: const <Widget>[Text('직책 탈퇴')]),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[Text("탈퇴 가능한 부서가 없습니다.",),],
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

    selectDepartmentId = AppCore.instance.getUser().departmentList[0].departmentId;
    selectDepartmentName = AppCore.instance.getUser().departmentList[0].departmentName;

    if (AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.isNotEmpty) {
      selectPositionId = AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.departmentId == selectDepartmentId).positionId;
      selectPositionName = AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.departmentId == selectDepartmentId).positionName;
    }
  }

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
            value: selectDepartmentName,
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
                selectDepartmentName = AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentName == value).departmentName;
                if (AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.length > 0) {
                  selectPositionId = AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList[0].positionId;
                  selectPositionName = AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList[0].positionName;
                }
                else {
                  selectPositionId = -1;
                  selectPositionName = '';
                }
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
            value: selectPositionName,
            items: AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.where((position) => position.departmentId == selectDepartmentId).length > 0 ? AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentId == selectDepartmentId).positionList.where((element) => element.departmentId == selectDepartmentId).map(
              (value) {
                return DropdownMenuItem<String>(
                  value: value.positionName,
                  child: Text(value.positionName),
                  );
                },
              ).toList() : [],
            onChanged: (value) {
              setState(() {
                  selectPositionId = AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.positionName == value).positionId;
                  selectPositionName = AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.positionName == value).positionName;
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
                  if (selectDepartmentId == -1 || selectPositionId == -1) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      title: Column(children: const <Widget>[Text('직책 탈퇴')]),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[Text("정상적으로 부서와 직책이 선택되지 않았습니다. 다시 시도해주세요.",),],
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
                  }
                  else {
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
                  }
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
  String address = '/positionLeave';
  Map<String, dynamic> body = {
    'userId': AppCore.instance.getUser().userId.text,
    'departmentId': selectDepartmentId,
    'positionId' : selectPositionId,
  };

  ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

  if (responseData.statusCode == 200) {
    if (responseData.body == 'true') {
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