import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app_core.dart';
import '../../models/response_data.dart';
import '../../widgets/dropdown_button_v1.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class PositionLeave extends StatefulWidget {
  const PositionLeave({super.key});

  @override
  State<PositionLeave> createState() => _PositionLeave();
}

class _PositionLeave extends State<PositionLeave> {
  int selectDepartmentId = AppCore.instance.getUser().selectGroup.departmentList[0].departmentId;
  String selectDepartmentName = '';
  int selectPositionId = -1;
  String selectPositionName = '';

  @override
  void initState() {
    super.initState();

    selectDepartmentId = AppCore.instance.getUser().selectGroup.departmentList[0].departmentId;
    selectDepartmentName = AppCore.instance.getUser().selectGroup.departmentList[0].departmentName;

    if (AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.isNotEmpty) {
      selectPositionId = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.departmentId == selectDepartmentId).positionId;
      selectPositionName = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.departmentId == selectDepartmentId).positionName;
    }
  }

  Future<bool> leave(int selectDepartmentId, int selectPositionId) async {
    String address = '/positionLeave';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
      'departmentId': selectDepartmentId,
      'positionId' : selectPositionId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

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
              text: '직책 탈퇴',
            ),
            Text(
              '부서'
            ),
            SizedBox(
              height: 20,
            ),
            DropdownButtonV1(
              isExpanded: true,
              value: selectDepartmentName,
              items: AppCore.instance.getUser().selectGroup.departmentList.map(
                (value) { 
                  return DropdownMenuItem<String>(
                    value: value.departmentName,
                    child: Text(value.departmentName),
                    );
                  },
                ).toList(),
              onChanged: (value) {
                setState(() {
                  selectDepartmentId = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((department) => department.departmentName == value).departmentId;
                  selectDepartmentName = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentName == value).departmentName;
                  if (AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.isNotEmpty) {
                    selectPositionId = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList[0].positionId;
                    selectPositionName = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList[0].positionName;
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
            DropdownButtonV1(
              isExpanded: true,
              value: selectPositionName,
              items: AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.where((position) => position.departmentId == selectDepartmentId).isNotEmpty ? AppCore.instance.getUser().selectGroup.departmentList.firstWhere((department) => department.departmentId == selectDepartmentId).positionList.where((element) => element.departmentId == selectDepartmentId).map(
                (value) {
                  return DropdownMenuItem<String>(
                    value: value.positionName,
                    child: Text(value.positionName),
                    );
                  },
                ).toList() : [],
              onChanged: (value) {
                setState(() {
                    selectPositionId = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.positionName == value).positionId;
                    selectPositionName = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.positionName == value).positionName;
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
                style: TextButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 90, 68, 223),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                onPressed: () async {
                  if (selectDepartmentId == -1 || selectPositionId == -1) {
                    AppCore.showMessage(context, '직책 탈퇴', '정상적으로 부서와 직책이 선택되지 않았습니다. 다시 시도해주세요.', ActionType.ok, () => {
                      Navigator.pop(context),
                    });
                  }
                  else {
                    AppCore.showMessage(context, '직책 탈퇴', '선택한 직책을 탈퇴하시겠습니까?', ActionType.yesNo, () => {
                      Navigator.pop(context),
                      leave(selectDepartmentId, selectPositionId).then((bool result) {
                        if (result) {
                          Navigator.pop(context);
                        }
                        else {
                          AppCore.showMessage(context, '직책 탈퇴', '탈퇴 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                            Navigator.pop(context);
                          });
                        }
                      }),
                    });
                  }
                },
                child: Text(
                  '탈퇴',
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