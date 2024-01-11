import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/models/budget_type.dart';
import 'package:test/widgets/text_form_field_v1.dart';

import '../../app_core.dart';
import '../../models/response_data.dart';
import '../../widgets/dropdown_button_v1.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class BudgetAdd extends StatefulWidget {
  const BudgetAdd({super.key});

  @override
  State<BudgetAdd> createState() => _BudgetAdd();
}

class _BudgetAdd extends State<BudgetAdd> {
  List<BudgetType> budgetTypeList = <BudgetType>[];
  int selectDepartmentId = -1;
  String selectDepartmentName = '';
  int budgetTypeId = -1;
  String budgetTypeName = '';
  TextEditingController budgetYear = TextEditingController();
  TextEditingController budgetMonth = TextEditingController();
  TextEditingController budgetTitle = TextEditingController();
  TextEditingController budgetMemo = TextEditingController();
  TextEditingController budgetAmount = TextEditingController();

  @override
  void initState() {
    super.initState();

    selectDepartmentId = AppCore.instance.getUser().selectGroup.departmentList[0].departmentId;
    selectDepartmentName = AppCore.instance.getUser().selectGroup.departmentList[0].departmentName;

    budgetTypeList.add(BudgetType());
    getBudgetTypeList();

    budgetYear.text = DateTime.now().year.toString();
    budgetMonth.text = DateTime.now().month.toString();
  }

  Future<void> getBudgetTypeList() async {
    String address = '/getBudgetTypeList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
      'groupId': AppCore.instance.getUser().selectGroup.groupId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      List<BudgetType> tempList = <BudgetType>[];

      for (var json in jsonDecode(responseData.body)) {
        BudgetType budgetType = BudgetType();
        budgetType.setData(json);

        tempList.add(budgetType);
      }

      if (tempList.isEmpty) {
        // ignore: use_build_context_synchronously
        AppCore.showMessage(context, '예산 추가', '예산 구분 항목이 없습니다. 예산 구분을 먼저 설정하세요.', ActionType.ok, () {
          Navigator.pop(context);
          Navigator.pop(context);
          return;
        });
      }

      if (budgetTypeList.isNotEmpty && tempList.isNotEmpty) {
        budgetTypeId = tempList[0].budgetTypeId;
        budgetTypeName = tempList[0].budgetTypeName;

        setState(() {
          budgetTypeList = tempList;
        });
      }
    }
  }

  String setData() {
    if (selectDepartmentId == -1) {
      return '부서가 선택되지 않았습니다.';
    }
    else if (budgetTypeId == -1) {
      return '예산 구분이 선택되지 않았습니다.';
    }
    else if (budgetYear.text.isEmpty) {
      return '예산 추가할 연도가 입력되지 않았습니다.';
    }
    else if (budgetMonth.text.isEmpty) {
      return '예산 추가할 월이 입력되지 않았습니다.';
    }
    else if (budgetAmount.text.isEmpty) {
      return '예산 금액이 입력되지 않았습니다.';
    }
    else if (budgetTitle.text.isEmpty) {
      return '예산명이 입력되지 않았습니다.';
    }

    return '';
  }

  Future<bool> budgetAdd() async {
    String address = '/budgetAdd';
    Map<String, dynamic> body = {
      'departmentId': selectDepartmentId,
      'budgetTypeId': budgetTypeId,
      'budgetTitle': budgetTitle.text,
      'budgetMemo': budgetMemo.text,
      'budgetAmount': budgetAmount.text,
      'budgetDate': '${budgetYear.text.toString().padLeft(4, '0')}-${budgetMonth.text.toString().padLeft(2, '0')}',
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: '예산 추가',
              ),
              Text(
                '부서',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
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
                    budgetTypeId = budgetTypeList.where((budgetType) => budgetType.departmentId == selectDepartmentId).toList().isNotEmpty ? budgetTypeList.where((budgetType) => budgetType.departmentId == selectDepartmentId).toList()[0].budgetTypeId : -1;
                    budgetTypeName = budgetTypeList.where((budgetType) => budgetType.departmentId == selectDepartmentId).toList().isNotEmpty ? budgetTypeList.where((budgetType) => budgetType.departmentId == selectDepartmentId).toList()[0].budgetTypeName : '';
                  });
                }
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '예산 구분',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonV1(
                isExpanded: true,
                value: budgetTypeName,
                items: budgetTypeList.where((budgetType) => budgetType.departmentId == selectDepartmentId).map(
                  (value) {
                    return DropdownMenuItem<String>(
                      value: value.budgetTypeName,
                      child: Text(value.budgetTypeName),
                      );
                    },
                  ).toList(),
                onChanged: (value) {
                  setState(() {
                    budgetTypeId = budgetTypeList.firstWhere((element) => element.budgetTypeName == value).budgetTypeId;
                    budgetTypeName = budgetTypeList.firstWhere((element) => element.budgetTypeName == value).budgetTypeName;
                  });
                }
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '금액',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldV1(
                controller: budgetAmount,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                  FocusScope.of(context).nextFocus();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '예산명',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldV1(
                controller: budgetTitle,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                  FocusScope.of(context).nextFocus();
                },
                maxLength: 32,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '메모',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldV1(
                controller: budgetMemo,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLength: 512,
                maxLines: 5,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '예산월',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: TextFormFieldV1(
                      textAlign: TextAlign.center,
                      counterText: '',
                      suffixIcon: Container(
                        width: 50,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Text(
                          '년',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      controller: budgetYear,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {FocusScope.of(context).nextFocus();},
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 3,
                    child: TextFormFieldV1(
                      textAlign: TextAlign.center,
                      counterText: '',
                      suffixIcon: Container(
                        width: 50,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Text(
                          '월',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: budgetMonth,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {FocusScope.of(context).nextFocus();},
                    ),
                  ),
                ],
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
                    String validationMessage = setData();
                    if (validationMessage.isEmpty) {
                      if (await budgetAdd()) {
                        // ignore: use_build_context_synchronously
                        AppCore.showMessage(context, '예산 추가', '추가 완료', ActionType.ok, () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        });
                      }
                      else {
                        // ignore: use_build_context_synchronously
                        AppCore.showMessage(context, '예산 추가', '예산 추가 저장 실패', ActionType.ok, () {
                          Navigator.pop(context);
                        });
                      }
                    }
                    else {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '예산 추가', validationMessage, ActionType.ok, () {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    '추가',
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