import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import '../../models/response_data.dart';
import '../home.dart';
import '../screen_frame.dart';

class DepartmentLeave extends StatefulWidget {
  const DepartmentLeave({super.key});

  @override
  State<DepartmentLeave> createState() => _DepartmentLeave();
}

class _DepartmentLeave extends State<DepartmentLeave> {
  int selectDepartmentId = -1;
  String selectDepartmentName = '';

  @override
  void initState() {
    super.initState();

    if (AppCore.instance.getUser().departmentList.isEmpty) {
      AppCore.showMessage(context, '부서 탈퇴', '탈퇴 가능한 부서가 없습니다.', ActionType.ok, () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }

    selectDepartmentId = AppCore.instance.getUser().departmentList[0].departmentId;
    selectDepartmentName = AppCore.instance.getUser().departmentList[0].departmentName;
  }

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
                selectDepartmentName = AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentName == value).departmentName;
              });
            }
          ),
          TextButton(
            onPressed: () {
              AppCore.showMessage(context, '부서 탈퇴', '선택한 부서를 탈퇴하시겠습니까?', ActionType.yesNo, () {
                Navigator.pop(context);
                leave(selectDepartmentId).then((bool result) {
                  if (result) {
                    AppCore.showMessage(context, '재시작', '부서가 변경되어 다시 시작합니다.', ActionType.ok, () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home()), (route) => false);
                    });
                  }
                  else {
                    AppCore.showMessage(context, '부서 탈퇴', '탈퇴 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                      Navigator.pop(context);
                    });
                  }
                });
                Navigator.pop(context);
              });
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
  String address = '/departmentLeave';
  Map<String, dynamic> body = {
    'userId': AppCore.instance.getUser().userId.text,
    'departmentId': selectDepartmentId,
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