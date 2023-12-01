import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/models/budget.dart';
import 'package:test/screens/budget/budget_manage.dart';

import '../../app_core.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class BudgetList extends StatefulWidget {
  const BudgetList({super.key});

  @override
  State<BudgetList> createState() => _BudgetAddList();
}

class _BudgetAddList extends State<BudgetList> {
  List<Budget> budgetList = <Budget>[];

  @override
  void initState() {
    super.initState();

    getBudgetList();
  }

  Future<void> getBudgetList() async {
    String address = '/getBudgetList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      List<Budget> tempList = <Budget>[];

      for (var json in jsonDecode(responseData.body)) {
        Budget budget = Budget();
        budget.setData(json);

        tempList.add(budget);
      }

      setState(() {
        budgetList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          TitleText(
            text: '예산 추가 목록',
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: budgetList.length,
            itemBuilder: (BuildContext context, int index) {
              final budget = budgetList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetManage(budget: budget,)),).then((value) {
                    if (value == true) {
                      getBudgetList();
                    }
                  });
                },
                child: Column (
                  children: [
                    ListTile(
                      leading: Text(budget.budgetTitle),
                    ),
                    Divider(),
                  ]
                ),
              );
            }
          )
        ],
      ),
    );
  }
}