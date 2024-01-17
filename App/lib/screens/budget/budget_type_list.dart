import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../app_core.dart';
import '../../models/budget_type.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';
import 'budget_type_add.dart';
import '../screen_frame.dart';

class BudgetTypeList extends StatefulWidget {
  const BudgetTypeList({super.key});

  @override
  State<BudgetTypeList> createState() => _BudgetTypeList();
}

class _BudgetTypeList extends State<BudgetTypeList> {
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
      'groupId': AppCore.instance.getUser().selectGroup.groupId,
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
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '예산 항목',
            ),
            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: budgetTypeList.length,
                itemBuilder: (BuildContext context, int index) {
                  final budgetType = budgetTypeList[index];

                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetTypeAdd(budgetType: budgetType,)),);
                      getBudgetTypeList();
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
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          budgetType.departmentName,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          budgetType.budgetTypeName,
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          margin: EdgeInsets.fromLTRB(2, 10, 2, 10),
                                          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(20)),
                                            color: Color.fromARGB(236, 214, 215, 252),
                                          ),
                                          child: Text(
                                            budgetType.activationStatus ? '사용중' : '미사용',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  );
                }
              ),
            ),
            SizedBox(
              height: 20,
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
                  if (AppCore.instance.getUser().selectGroup.departmentList.isEmpty) {
                    AppCore.showMessage(context, '예산 항목 추가', '설정 가능한 부서가 없습니다. 부서를 먼저 신청하세요', ActionType.ok, () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  }
                  else {
                    await Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetTypeAdd(budgetType: BudgetType(),)),);

                    getBudgetTypeList();
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
    );
  }
}