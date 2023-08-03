import 'dart:convert';
import 'package:flutter/material.dart';
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
  int selectDepartmentId = -1;
  String selectDepartmentName = '';
  int selectPositionId = -1;
  String selectPositionName = '';
  List<Department> departmentList = <Department>[];

  @override
  void initState() {
    super.initState();

    if (AppCore.instance.getUser().departmentList.isEmpty) {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(children: const <Widget>[Text('직책 신청')]),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[Text("직책 신청 가능한 부서가 없습니다. 부서를 먼저 신청하세요.",),],
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
    
    departmentList = AppCore.instance.getUser().departmentList;
    selectDepartmentId = AppCore.instance.getUser().departmentList[0].departmentId;
    selectDepartmentName = AppCore.instance.getUser().departmentList[0].departmentName;

    for (Department department in departmentList) {
      department.positionList = <Position>[];
      getDepartmentPositionList(department.departmentId);
    }
  }

  void getDepartmentPositionList(int departmentId) async {
    String address = '/getDepartmentPositionList';
    Map<String, int> body = {
      'departmentId': departmentId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      List<Position> tempList = <Position>[];
      tempList.add(Position());
      for (var json in jsonDecode(responseData.body))
      {
        Position position = Position();
        position.setData(json);

        var test = AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentId == departmentId).positionList.firstWhere((element) => element.positionId == position.positionId, orElse: () => Position());
        // if () {
          departmentList.firstWhere((department) => department.departmentId == position.departmentId).positionList.add(position);
        // }
      }

      // if (departmentList[0].positionList.isNotEmpty) {
        setState(() {
          selectPositionId = departmentList[0].positionList[0].positionId;
          selectPositionName = departmentList[0].positionList[0].positionName;
        });
      // }
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
                // if (departmentList.firstWhere((department) => department.departmentId == selectDepartmentId).positionList.isNotEmpty) {
                  selectPositionId = departmentList.firstWhere((department) => department.departmentId == selectDepartmentId).positionList[0].positionId;
                  selectPositionName = departmentList.firstWhere((department) => department.departmentId == selectDepartmentId).positionList[0].positionName;
                // }
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
            value: selectPositionName,
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
                // if (departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.isNotEmpty) {
                  selectPositionId = departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.positionName == value).positionId;
                  selectPositionName = departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.positionName == value).positionName;
                // }
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
              if (await positionRequest(selectDepartmentId, selectPositionId)) {
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
              else {
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