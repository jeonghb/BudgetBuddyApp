import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app_core.dart';
import '../../models/position.dart';
import '../../models/department.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

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
  List<Position> positionList = <Position>[];

  @override
  void initState() {
    super.initState();

    if (AppCore.instance.getUser().departmentList.isEmpty) {
      AppCore.showMessage(context, '직책 신청', '직책 신청 가능한 부서가 없습니다. 부서를 먼저 신청하세요.', ActionType.ok, () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
    
    departmentList = AppCore.instance.getUser().departmentList;
    selectDepartmentId = AppCore.instance.getUser().departmentList[0].departmentId;
    selectDepartmentName = AppCore.instance.getUser().departmentList[0].departmentName;
    positionList.add(Position());
    selectPositionId = positionList[0].positionId;
    selectPositionName = positionList[0].positionName;

    setListData();
  }

  void setListData() async {
    await getRequestPossibilityDepartmentPositionList();
    
    var result = positionList.firstWhereOrNull((element) => element.departmentId == selectDepartmentId);
    if (result != null) {
      selectPositionId = result.positionId;
      selectPositionName = result.positionName;
    }
  }

  Future<void> getRequestPossibilityDepartmentPositionList() async {
    String address = '/getRequestPossibilityDepartmentPositionList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      List<Position> tempList = <Position>[];

      for (var json in jsonDecode(responseData.body))
      {
        Position position = Position();
        position.setData(json);

        tempList.add(position);
      }

      setState(() {
        positionList.addAll(tempList);
      });
    }
  }

  Future<bool> positionRequest(int selectDepartmentId, int selectPositiontId) async {
    String address = '/positionRequest';
    Map<String, dynamic> body = {
      'requestUserId' : AppCore.instance.getUser().userId,
      'requestPositionId' : selectPositiontId,
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

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '직책 신청',
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
                  var result = positionList.firstWhereOrNull((element) => element.departmentId == selectDepartmentId);
                  if (result != null) {
                    selectPositionId = result.positionId;
                    selectPositionName = result.positionName;
                  }
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
              items: positionList.where((position) => position.departmentId == selectDepartmentId).isNotEmpty ? positionList.where((position) => position.departmentId == selectDepartmentId).map(
                (value) { 
                  return DropdownMenuItem<String>(
                    value: value.positionName,
                    child: Text(value.positionName),
                    );
                  },
                ).toList() : [],
              onChanged: (value) {
                setState(() {
                    selectPositionId = positionList.firstWhere((element) => element.positionName == value).positionId;
                    selectPositionName = positionList.firstWhere((element) => element.positionName == value).positionName;
                });
              }
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(130),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 90, 68, 223),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                onPressed: () async {
                  if (await positionRequest(selectDepartmentId, selectPositionId)) {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '직책 신청', '요청 완료', ActionType.ok, () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                }
                else {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '직책 신청', '요청에 실패했습니다.', ActionType.ok, () {
                    Navigator.pop(context);
                  });
                }
                },
                child: Text(
                  '신청',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]
        )
      ),
    );
  }
}