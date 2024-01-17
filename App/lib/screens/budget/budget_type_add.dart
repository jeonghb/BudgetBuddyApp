import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/widgets/text_form_field_v1.dart';

import '../../models/budget_type.dart';
import '../../widgets/dropdown_button_v1.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class BudgetTypeAdd extends StatefulWidget {
  final BudgetType budgetType;

  const BudgetTypeAdd({
    super.key,
    required this.budgetType,
  });

  @override
  State<BudgetTypeAdd> createState() => _BudgetTypeAdd();
}

class _BudgetTypeAdd extends State<BudgetTypeAdd> {
  int selectDepartmentId = -1;
  String selectDepartmentName = '';
  TextEditingController budgetTypeName = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.budgetType.departmentId != -1) {
      selectDepartmentId = widget.budgetType.departmentId;
      selectDepartmentName = widget.budgetType.departmentName;
    }
    else {
      selectDepartmentId = AppCore.instance.getUser().selectGroup.departmentList[0].departmentId;
      selectDepartmentName = AppCore.instance.getUser().selectGroup.departmentList[0].departmentName;
    }
    
    budgetTypeName.text = widget.budgetType.budgetTypeName;
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
                text: '예산 항목 ${widget.budgetType.budgetTypeId != -1 ? '관리' : '추가'}',
              ),
              Text(
                '부서 선택',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              DropdownButtonV1(
                isExpanded: true,
                value: selectDepartmentName,
                items: AppCore.instance.getUser().selectGroup.departmentList.isNotEmpty ? AppCore.instance.getUser().selectGroup.departmentList.map(
                  (value) { 
                    return DropdownMenuItem<String>(
                      value: value.departmentName,
                      child: Text(value.departmentName),
                      );
                    },
                  ).toList() : [],
                onChanged: (value) {
                  setState(() {
                    selectDepartmentId = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((department) => department.departmentName == value).departmentId;
                    selectDepartmentName = AppCore.instance.getUser().selectGroup.departmentList.firstWhere((department) => department.departmentName == value).departmentName;
                  });
                }
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                '항목명',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormFieldV1(
                controller: budgetTypeName,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
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
                          if (await widget.budgetType.budgetTypeActivationStatusSave(!widget.budgetType.activationStatus)) {
                            setState(() {
                              widget.budgetType.activationStatus = !widget.budgetType.activationStatus;
                            });

                            // ignore: use_build_context_synchronously
                            AppCore.showMessage(context, '예산 항목', widget.budgetType.activationStatus ? '사용 처리 완료' : '미사용 처리 완료', ActionType.ok, () {
                              Navigator.pop(context);
                            });
                          }
                          else {
                            // ignore: use_build_context_synchronously
                            AppCore.showMessage(context, '예산 항목', '저장 실패', ActionType.ok, () {
                              Navigator.pop(context);
                            });
                          }
                        },
                        child: Text(
                          widget.budgetType.activationStatus ? '미사용' : '사용',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
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
                          if (budgetTypeName.text.isNotEmpty) {
                            widget.budgetType.departmentId = selectDepartmentId;
                            widget.budgetType.budgetTypeName = budgetTypeName.text;
                            if (await widget.budgetType.budgetTypeAdd()) {
                              // ignore: use_build_context_synchronously
                              AppCore.showMessage(context, '예산 항목 추가', '추가 완료', ActionType.ok, () {
                                Navigator.pop(context);
                                Navigator.pop(context, true);
                              });
                            }
                            else {
                              // ignore: use_build_context_synchronously
                              AppCore.showMessage(context, '예산 항목 추가', '예산 항목 추가에 실패했습니다', ActionType.ok, () {
                                Navigator.pop(context);
                              });
                            }
                          }
                          else {
                            AppCore.showMessage(context, '예산 항목 추가', '예산 항목명이 입력되지 않았습니다', ActionType.ok, () {
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
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}