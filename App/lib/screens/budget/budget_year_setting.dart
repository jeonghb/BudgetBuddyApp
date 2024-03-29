import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/widgets/text_form_field_v1.dart';

import '../../models/budget_year.dart';
import '../../models/response_data.dart';
import '../../widgets/dropdown_button_v1.dart';
import '../../widgets/title_text.dart';
import '../home.dart';
import '../screen_frame.dart';

class BudgetYearSetting extends StatefulWidget {
  const BudgetYearSetting({super.key});

  @override
  State<BudgetYearSetting> createState() => _BudgetYearSetting();
}

class _BudgetYearSetting extends State<BudgetYearSetting> {
  List<BudgetYear> budgetYearList = <BudgetYear>[];
  int selectDepartmentId = -1;
  String selectDepartmentName = '';
  int selectYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();

    selectDepartmentId = AppCore.instance.getUser().selectGroup.departmentList[0].departmentId;
    selectDepartmentName = AppCore.instance.getUser().selectGroup.departmentList[0].departmentName;

    getBudgetYearList();
  }

  Future<void> getBudgetYearList() async {
    String address = '/getBudgetYearList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
      'groupId': AppCore.instance.getUser().selectGroup.groupId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      List<BudgetYear> dbList = <BudgetYear>[];

      for (var json in jsonDecode(responseData.body)) {
        BudgetYear budgetYear = BudgetYear();
        budgetYear.setData(json);

        dbList.add(budgetYear);
      }

      List<BudgetYear> tempList = <BudgetYear>[];
      
      for (int year = 2024; year <= DateTime.now().year + 1; year++) {
        for (int departmentId in AppCore.instance.getUser().selectGroup.departmentList.map((e) => e.departmentId,)) {
          BudgetYear temp = BudgetYear();
          temp.departmentId = departmentId;
          temp.year = year;

          if (dbList.firstWhereOrNull((element) => element.departmentId == departmentId && element.year == year) != null) {
            temp.budgetAmount.text = dbList.firstWhere((element) => element.departmentId == departmentId && element.year == year).budgetAmount.text;
          }

          tempList.add(temp);
        }
      }

      setState(() {
        budgetYearList = tempList;
        selectYear = DateTime.now().year;
      });
    }
  }

  String setData() {
    if (selectDepartmentId == -1) {
      return '부서가 선택되지 않았습니다';
    }
    if (budgetYearList.firstWhere((element) => element.departmentId == selectDepartmentId && element.year == selectYear).budgetAmount.text == '') {
      return '예산 금액이 입력되지 않았습니다';
    }

    return '';
  }

  Future<bool> setbudgetYearAmount() async {
    String address = '/setBudgetYearAmount';
    Map<String, dynamic> body = {
      'departmentId': selectDepartmentId,
      'year': selectYear,
      'budgetAmount': budgetYearList.firstWhere((element) => element.departmentId == selectDepartmentId && element.year == selectYear).budgetAmount.text,
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: '예산 설정',
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
              DropdownButtonV1(
                // isExpanded: true,
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
                    selectDepartmentId = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentName == value).departmentId;
                    selectDepartmentName = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((element) => element.departmentName == value).departmentName;
                  });
                }
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '설정 연도',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonV1(
                // isExpanded: true,
                value: selectYear.toString(),
                items: budgetYearList.where((element) => element.departmentId == selectDepartmentId).map(
                  (value) { 
                    return DropdownMenuItem<String>(
                      value: value.year.toString(),
                      child: Text(value.year.toString()),
                      );
                    },
                  ).toList(),
                onChanged: (value) {
                  setState(() {
                    selectYear = AppCore.parseInt(value.toString());
                  });
                }
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '설정 금액',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldV1(
                keyboardType: TextInputType.number,
                maxLength: 10,
                textAlign: TextAlign.right,
                controller: budgetYearList.firstWhereOrNull((element) => element.departmentId == selectDepartmentId && element.year == selectYear) != null ? budgetYearList.firstWhere((element) => element.departmentId == selectDepartmentId && element.year == selectYear).budgetAmount : TextEditingController(),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(130),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  onPressed: () async {
                    String validationMessage = setData();
                    if (validationMessage.isEmpty) {
                      if (await setbudgetYearAmount()) {
                        // ignore: use_build_context_synchronously
                        AppCore.showMessage(context, '예산 설정', '예산 설정 완료', ActionType.ok, () {
                          Navigator.pop(context);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Home(groupId: AppCore.instance.getUser().selectGroup.groupId)),);
                        });
                      }
                      else {
                        // ignore: use_build_context_synchronously
                        AppCore.showMessage(context, '예산 설정', '예산 설정을 실패하였습니다', ActionType.ok, () {
                          Navigator.pop(context);
                        });
                      }
                    }
                    else {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '예산 설정', validationMessage, ActionType.ok, () {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    '저장',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}