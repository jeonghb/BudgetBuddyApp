import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/initialize.dart';
import '../../models/response_data.dart';
import '../../widgets/dropdown_button_v1.dart';
import '../../widgets/title_text.dart';
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

    selectDepartmentId = AppCore.instance.getUser().selectGroup.departmentList[0].departmentId;
    selectDepartmentName = AppCore.instance.getUser().selectGroup.departmentList[0].departmentName;
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
              text: '부서 탈퇴',
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
                  selectDepartmentName = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((department) => department.departmentName == value).departmentName;
                });
              }
            ),
            SizedBox(
              height: 10,
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
                  AppCore.showMessage(context, '부서 탈퇴', '선택한 부서를 탈퇴하시겠습니까?', ActionType.yesNo, () async {
                    Navigator.pop(context);
                    
                    leave(selectDepartmentId).then((bool result) {
                      if (result) {
                        AppCore.showMessage(context, '재시작', '부서가 변경되어 다시 시작합니다', ActionType.ok, () async {
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Initialize()), (route) => false);
                        });
                      }
                      else {
                        AppCore.showMessage(context, '부서 탈퇴', '탈퇴 처리 중 오류가 발생하였습니다. 다시 시도해주세요', ActionType.ok, () {
                          Navigator.pop(context);
                        });
                      }
                    });
                  });
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
        ),
      ),
    );
  }
}

Future<bool> leave(int selectDepartmentId) async {
  String address = '/departmentLeave';
  Map<String, dynamic> body = {
    'userId': AppCore.instance.getUser().userId,
    'departmentId': selectDepartmentId,
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