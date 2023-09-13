import 'package:flutter/material.dart';
import 'package:test/screens/budget/budget_add.dart';
import 'package:test/screens/budget/budget_list.dart';
import 'package:test/screens/first_run.dart';

import '../app_core.dart';
import '../models/department.dart';
import '../models/position.dart';
import '../models/receipt.dart';
import '../screens/auth/auth_manage.dart';
import '../screens/budget/budget_type_manage.dart';
import '../screens/budget/budget_year_setting.dart';
import '../screens/receipt/receipt_approval_list.dart';
import '../screens/receipt/receipt_request_list.dart';
import '../screens/user/my_page.dart';
import '../screens/receipt/receipt_request.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawer();
}

class _MenuDrawer extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    List<ListTile> menuList = [];
    List<Position> userPositionList = <Position>[];

    for (Department department in AppCore.instance.getUser().departmentList) {
      userPositionList.addAll(department.positionList);
    }

    if (AppCore.authCheck('영수증 제출')) {
      menuList.add(
        ListTile(
          leading: Icon(Icons.add_box_outlined),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
          title: Text('영수증 제출',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequest(receipt: Receipt(),)),);
          },
        ),
      );
    }
    if (AppCore.authCheck('영수증 결재')) {
      menuList.add(
        ListTile(
          leading: Icon(Icons.check),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
          title: Text('영수증 결재',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptApprovalList()));
          }
        ),
      );
    }
    if (AppCore.authCheck('영수증 제출 내역')) {
      menuList.add(
        ListTile(
          leading: Icon(Icons.list),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
          title: Text('영수증 제출 내역',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequestList()));
          },
        ),
      );
    }
    if (AppCore.authCheck('예산 추가')) {
      menuList.add(
        ListTile(
          leading: Icon(Icons.check),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
          title: Text('예산 추가',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetAdd()));
          }
        )
      );
    }
    if (AppCore.authCheck('예산 추가내역')) {
      menuList.add(
        ListTile(
          leading: Icon(Icons.check),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
          title: Text('예산 추가내역',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetList()));
          }
        )
      );
    }
    if (AppCore.authCheck('월별 정산')) {
      menuList.add(
        ListTile(
          leading: Icon(Icons.edit_document),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
          title: Text('월별 정산',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
          ),
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptCalculate(departmentId: AppCore.instance.getUser().departmentIdList)));
          },
        ),
      );
    }
    if (AppCore.authCheck('연도별 예산 설정')) {
      menuList.add(
        ListTile(
          leading: Icon(Icons.add_box_outlined),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
          title: Text('연도별 예산 설정',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetYearSetting()));
          },
        ),
      );
    }
    if (AppCore.authCheck('예산 항목 관리')) {
      menuList.add(
        ListTile(
          leading: Icon(Icons.add_box_outlined),
          iconColor: Color.fromARGB(255, 90, 68, 223),
          focusColor: Color.fromARGB(255, 90, 68, 223),
          title: Text(
            '예산 항목 관리',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            )
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => BudgetTypeManage()));
          },
        ),
      );
    }

    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 20,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close),
                ),
              ),
            ]
          ),
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Text(
                        '  ${AppCore.instance.getUser().userName.text}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ) 
                ),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: userPositionList.length,
                    itemBuilder: (BuildContext context, int index) {
                      String positionName = userPositionList[index].positionName;

                      return Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: SizedBox(
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              margin: EdgeInsets.fromLTRB(4, 0, 0, 4),
                              padding: EdgeInsets.fromLTRB(4, 2, 2, 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                                color: Color.fromARGB(236, 214, 215, 252),
                              ),
                              child: Text(
                                positionName.isNotEmpty ? positionName : '없음',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Expanded(
                            child: SizedBox(
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: BorderSide(color: Colors.grey),
                    ),
                    minimumSize: Size(80, double.infinity),
                    padding: EdgeInsets.all(0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ID1.png',
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '마이페이지',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.black,
                        ),
                      ),
                    ]
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                AppCore.authCheck('authManage') ? 
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AuthManage()));
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: Colors.grey),
                    ),
                    minimumSize: Size(70, double.infinity),
                    padding: EdgeInsets.all(0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.lock_outlined,
                        size: 13
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '권한관리',
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ) : SizedBox(),
              ],
            )
          ),
          Container(
            width: double.infinity,
            height: 20,
            color: Colors.white,
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.grey,
          ),
          Expanded(
            flex: 26,
            child: ListView.builder(
              itemCount: menuList.length,
              itemBuilder: (context, index) {
                return menuList[index];
              }
            )
          ),
          Container(
            width: double.infinity,
            height: 5,
            color: Colors.grey,
          ),
          TextButton(
            onPressed: () {
              AppCore.showMessage(context, '로그아웃', '로그아웃 하시겠습니까?', ActionType.yesNo, () {
                AppCore.instance.logOut();
                
                Navigator.pop(context);
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirstRun()), (route) => false);
              });
            },
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: const [
                  Icon(
                    Icons.logout,
                    color: Colors.black,
                  ),
                  Text(
                    '로그아웃',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              )
            ),
          ),
        ],
    ),
    );
  }
}