import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:test/models/budget.dart';

import '../../app_core.dart';
import '../../models/budget_type.dart';
import '../../models/response_data.dart';
import '../../widgets/dropdown_button_v1.dart';
import '../../widgets/text_form_field_v1.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class BudgetManage extends StatefulWidget {
  final Budget budget;

  const BudgetManage({super.key, required this.budget});

  @override
  State<BudgetManage> createState() => _BudgetManage();
}

class _BudgetManage extends State<BudgetManage> {
  List<BudgetType> budgetTypeList = <BudgetType>[];
  TextEditingController budgetAmount = TextEditingController();
  TextEditingController budgetTitle = TextEditingController();
  TextEditingController budgetMemo = TextEditingController();
  TextEditingController budgetYear = TextEditingController();
  TextEditingController budgetMonth = TextEditingController();

  @override
  void initState() {
    super.initState();

    budgetAmount.text = widget.budget.budgetAmount.toString();
    budgetTitle.text = widget.budget.budgetTitle;
    budgetMemo.text = widget.budget.budgetMemo;
    budgetYear.text = widget.budget.budgetDate.substring(0, 4);
    budgetMonth.text = widget.budget.budgetDate.substring(6, 7);

    budgetTypeList.add(BudgetType());
    getBudgetTypeList();
  }

  Future<void> getBudgetTypeList() async {
    String address = '/getBudgetTypeList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      List<BudgetType> tempList = <BudgetType>[];
      tempList.add(BudgetType());

      for (var json in jsonDecode(responseData.body)) {
        BudgetType budgetType = BudgetType();
        budgetType.setData(json);

        tempList.add(budgetType);
      }

      setState(() {
        budgetTypeList = tempList;
      });
    }
  }

  String setData() {
    if (widget.budget.departmentId == -1) {
      return '부서가 선택되지 않았습니다.';
    }
    else if (widget.budget.budgetTypeId == -1) {
      return '예산 구분이 선택되지 않았습니다.';
    }
    else if (budgetYear.text.isEmpty) {
      return '예산 추가할 연도가 입력되지 않았습니다.';
    }
    else if (budgetMonth.text.isEmpty) {
      return '예산 추가할 월이 입력되지 않았습니다.';
    }
    else if (budgetAmount.text.isEmpty) {
      return '금액이 입력되지 않았습니다.';
    }
    else if (budgetTitle.text.isEmpty) {
      return '예산명이 입력되지 않았습니다.';
    }

    widget.budget.budgetDate = '${budgetYear.text.padLeft(4, '0')}-${budgetMonth.text.padLeft(2, '0')}';
    widget.budget.budgetAmount = int.parse(budgetAmount.text);
    widget.budget.budgetTitle = budgetTitle.text;
    widget.budget.budgetMemo = budgetMemo.text;

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TitleText(
              text: '예산 추가 정보',
            ),
            Text(
              '부서',
            ),
            DropdownButtonV1(
              isExpanded: true,
              value: widget.budget.departmentName,
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
                  widget.budget.departmentId = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((department) => department.departmentName == value).departmentId;
                  widget.budget.departmentName = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((department) => department.departmentName == value).departmentName;
                });
              }
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '예산 구분',
            ),
            DropdownButtonV1(
              isExpanded: true,
              value: widget.budget.budgetTypeName,
              items: budgetTypeList.firstWhereOrNull((element) => element.budgetTypeName == widget.budget.budgetTypeName) != null ? budgetTypeList.map(
                (value) {
                  return DropdownMenuItem<String>(
                    value: value.budgetTypeName,
                    child: Text(value.budgetTypeName),
                    );
                  },
                ).toList() : [],
              onChanged: (value) {
                setState(() {
                  widget.budget.budgetTypeId = budgetTypeList.firstWhere((element) => element.budgetTypeName == value).budgetTypeId;
                  widget.budget.budgetTypeName = budgetTypeList.firstWhere((element) => element.budgetTypeName == value).budgetTypeName;
                });
              }
            ),
            Text(
              '금액',
            ),
            TextFormFieldV1(
              controller: budgetAmount,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            Text(
              '예산명',
            ),
            TextFormFieldV1(
              controller: budgetTitle,
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
              maxLength: 32,
            ),
            Text(
              '메모',
            ),
            TextFormFieldV1(
              controller: budgetMemo,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              maxLength: 512,
            ),
            Text(
              '예산월',
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
                    onChanged: (value) {
                      int? month = int.tryParse(value);
                      if (month != null && (month < 1 || month > 12)) {
                        budgetMonth.value = TextEditingValue(
                          text: '12',
                          selection: TextSelection.collapsed(offset: 2),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                String validationMessage = setData();
                if (validationMessage.isEmpty) {
                  if (await widget.budget.budgetUpdate()) {
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '예산 수정', '수정 완료', ActionType.ok, () {
                      Navigator.pop(context);
                      Navigator.pop(context, true);
                    });
                  }
                  else {
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '예산 수정', '예산 수정 실패', ActionType.ok, () {
                      Navigator.pop(context);
                    });
                  }
                }
                else {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '예산 수정', validationMessage, ActionType.ok, () {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text(
                '추가',
              ),
            ),
            TextButton(
              onPressed: () async {
                if (await widget.budget.budgetDelete()) {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '예산 삭제', '삭제 완료', ActionType.ok, () {
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  });
                }
                else {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '예산 삭제', '예산 삭제 실패', ActionType.ok, () {
                    Navigator.pop(context);
                  });
                }
              },
              child: Text(
                '삭제',
              ),
            ),
          ],
        ),
      ),
    );
  }
}