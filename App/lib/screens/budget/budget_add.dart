import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/models/budget_type.dart';
import 'package:test/widgets/text_form_field_v1.dart';

import '../../app_core.dart';
import '../../models/response_data.dart';
import '../screen_frame.dart';

class BudgetAdd extends StatefulWidget {
  const BudgetAdd({super.key});

  @override
  State<BudgetAdd> createState() => _BudgetAdd();
}

class _BudgetAdd extends State<BudgetAdd> {
  List<BudgetType> budgetTypeList = <BudgetType>[];
  int departmentId = -1;
  String departmentName = '';
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

    if (AppCore.instance.getUser().departmentList.isEmpty) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(children: const <Widget>[Text('예산 추가')]),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[Text("소속된 부서가 없습니다.",),],
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
      return;
    }

    departmentId = AppCore.instance.getUser().departmentList[0].departmentId;
    departmentName = AppCore.instance.getUser().departmentList[0].departmentName;

    budgetTypeList.add(BudgetType());
    getBudgetTypeList();

    budgetYear.text = DateTime.now().year.toString();
    budgetMonth.text = DateTime.now().month.toString();
  }

  Future<void> getBudgetTypeList() async {
    String address = '/getBudgetTypeList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId.text,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      List<BudgetType> tempList = <BudgetType>[];
      tempList.add(BudgetType());

      for (var json in jsonDecode(responseData.body)) {
        BudgetType budgetType = BudgetType();
        budgetType.setData(json);

        tempList.add(budgetType);
      }

      budgetTypeList = tempList;
      if (budgetTypeList.isNotEmpty) {
        budgetTypeId = budgetTypeList[0].budgetTypeId;
        budgetTypeName = budgetTypeList[0].budgetTypeName;
      }
    }
  }

  String setData() {
    if (departmentId == -1) {
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

    return '';
  }

  Future<bool> budgetAdd() async {
    String address = '/budgetAdd';
    Map<String, dynamic> body = {
      'departmentId': departmentId,
      'budgetTypeId': budgetTypeId,
      'budgetTitle': budgetTitle.text,
      'budgetMemo': budgetMemo.text,
      'budgetAmount': budgetAmount.text,
      'budgetDate': '${budgetYear.text.toString().padLeft(4, '0')}-${budgetMonth.text.toString().padLeft(2, '0')}',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              '예산 추가',
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
            ),
            DropdownButton(
              isExpanded: true,
              value: departmentName,
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
                  departmentId = AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentName == value).departmentId;
                  departmentName = AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentName == value).departmentName;
                });
              }
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '예산 구분',
            ),
            DropdownButton(
              isExpanded: true,
              value: budgetTypeName,
              items: budgetTypeList.map(
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
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () async {
                String validationMessage = setData();
                if (validationMessage.isEmpty) {
                  if (await budgetAdd()) {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          title: Column(children: const <Widget>[Text('예산 추가')]),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[Text('추가 완료',),],
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
                      }
                    );
                  }
                  else {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          title: Column(children: const <Widget>[Text('예산 추가')]),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[Text('예산 추가 저장 실패',),],
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
                    );
                  }
                }
                else {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        title: Column(children: const <Widget>[Text('예산 추가')]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[Text(validationMessage,),],
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
                '추가',
              ),
            ),
          ],
        ),
      ),
    );
  }
}