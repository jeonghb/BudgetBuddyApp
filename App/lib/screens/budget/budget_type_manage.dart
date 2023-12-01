import 'dart:convert';

import 'package:flutter/material.dart';
import '../../app_core.dart';
import '../../models/budget_type.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';
import 'budget_type_add.dart';
import '../screen_frame.dart';

class BudgetTypeManage extends StatefulWidget {
  const BudgetTypeManage({super.key});

  @override
  State<BudgetTypeManage> createState() => _BudgetTypeManage();
}

class _BudgetTypeManage extends State<BudgetTypeManage> {
  List<BudgetType> budgetTypeList = <BudgetType>[];

  @override
  void initState() {
    super.initState();

    budgetTypeList.add(BudgetType());

    getBudgetTypeList();
  }

  void getBudgetTypeList() async {
    String address = '/getBudgetTypeList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      List<BudgetType> tempList = <BudgetType>[];

      for (var json in jsonDecode(responseData.body))
      {
        BudgetType budgetType = BudgetType();
        budgetType.setData(json);

        tempList.add(budgetType);
      }

      setState(() {
        budgetTypeList = tempList;  
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          TitleText(
            text: '예산 항목',
          ),
          Expanded(
            flex: 8,
            child: ListView.builder(
              itemCount: budgetTypeList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    budgetTypeList[index].budgetTypeName,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: TextButton(
              child: Text(
                '추가하기',
              ),
              onPressed: () {
                if (AppCore.instance.getUser().departmentList.isEmpty) {
                  AppCore.showMessage(context, '예산 항목 추가', '설정 가능한 부서가 없습니다. 부서를 먼저 신청하세요.', ActionType.ok, () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  });
                }
                
                Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetTypeAdd()),).then((value) {
                  if (value == true) {
                    getBudgetTypeList();
                  }
                });
              },
            ),
          ),
          Expanded(
            child: SizedBox(
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}