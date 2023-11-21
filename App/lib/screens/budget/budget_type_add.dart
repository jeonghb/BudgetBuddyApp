import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/widgets/text_form_field_v1.dart';

import '../../models/budget_type.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class BudgetTypeAdd extends StatefulWidget {
  const BudgetTypeAdd({super.key});

  @override
  State<BudgetTypeAdd> createState() => _BudgetTypeAdd();
}

class _BudgetTypeAdd extends State<BudgetTypeAdd> {
  BudgetType budgetType = BudgetType();
  int selectDepartmentId = -1;
  String selectDepartmentName = '';
  TextEditingController budgetTypeName = TextEditingController();

  @override
  void initState() {
    super.initState();

    selectDepartmentId = AppCore.instance.getUser().departmentList[0].departmentId;
    selectDepartmentName = AppCore.instance.getUser().departmentList[0].departmentName;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          TitleText(
            text: '부서',
          ),
          DropdownButton(
            isExpanded: true,
            value: selectDepartmentName,
            items: AppCore.instance.getUser().departmentList.isNotEmpty ? AppCore.instance.getUser().departmentList.map(
              (value) { 
                return DropdownMenuItem<String>(
                  value: value.departmentName,
                  child: Text(value.departmentName),
                  );
                },
              ).toList() : [],
            onChanged: (value) {
              setState(() {
                selectDepartmentId = AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentName == value).departmentId;
                selectDepartmentName = AppCore.instance.getUser().departmentList.firstWhere((department) => department.departmentName == value).departmentName;
              });
            }
          ),
          TextFormFieldV1(
            controller: budgetTypeName,
          ),
          TextButton(
            onPressed: () async {
              if (budgetTypeName.text.isNotEmpty) {
                budgetType.departmentId = selectDepartmentId;
                budgetType.budgetTypeName = budgetTypeName.text;
                if (await budgetType.budgetTypeAdd()) {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '예산 항목 추가', '추가 완료', ActionType.ok, () {
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  });
                }
                else {
                  // ignore: use_build_context_synchronously
                  AppCore.showMessage(context, '예산 항목 추가', '예산 항목 추가에 실패했습니다.', ActionType.ok, () {
                    Navigator.pop(context);
                  });
                }
              }
              else {
                AppCore.showMessage(context, '예산 항목 추가', '예산 항목명이 입력되지 않았습니다.', ActionType.ok, () {
                  Navigator.pop(context);
                });
              }
            },
            child: Text(
              '추가',
            ),
          ),
        ],
      ),
    );
  }
}