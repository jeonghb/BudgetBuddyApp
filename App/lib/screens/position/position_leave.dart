import 'package:flutter/material.dart';
import '../../app_core.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';
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
      AppCore.showMessage(context, '직책 탈퇴', '탈퇴 가능한 부서가 없습니다.', ActionType.ok, () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }

    selectDepartmentId = AppCore.instance.getUser().departmentList[0].departmentId;
    selectDepartmentName = AppCore.instance.getUser().departmentList[0].departmentName;

    if (AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.isNotEmpty) {
      selectPositionId = AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.departmentId == selectDepartmentId).positionId;
      selectPositionName = AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.firstWhere((element) => element.departmentId == selectDepartmentId).positionName;
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

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          TitleText(
            text: '직책 탈퇴',
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
                if (AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.isNotEmpty) {
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
            items: AppCore.instance.getUser().departmentList.firstWhere((element) => element.departmentId == selectDepartmentId).positionList.where((position) => position.departmentId == selectDepartmentId).isNotEmpty ? AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentId == selectDepartmentId).positionList.where((element) => element.departmentId == selectDepartmentId).map(
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
                  Navigator.pop(context),
                });
              }
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