import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test/models/budget.dart';

import '../../app_core.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';
import 'budget_manage.dart';

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
      'groupId': AppCore.instance.getUser().selectGroup.groupId,
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
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '예산 추가 목록',
            ),
            Expanded(
              child: ListView.builder(
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
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(31, 0, 0, 0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          budget.departmentName,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Text(
                                          budget.budgetDate,
                                        )
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          budget.budgetTypeName,
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Text(
                                          '${NumberFormat('#,###').format(budget.budgetAmount)}원',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  );
                }
              )
            ),
          ],
        ),
      ),
    );
  }
}