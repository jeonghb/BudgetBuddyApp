import 'package:flutter/material.dart';
import 'package:test/screens/first_run.dart';

import '../app_core.dart';
import '../models/receipt.dart';
import '../screens/receipt_request.dart';

class MenuDrawer extends StatefulWidget {
  const MenuDrawer({super.key});

  @override
  State<MenuDrawer> createState() => _MenuDrawer();
}

class _MenuDrawer extends State<MenuDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                // backgroundImage: AppCore.instance.getUser().image,
              ),
              accountName: Text(AppCore.instance.getUser().userName.text),
              accountEmail: Text(AppCore.instance.getUser().userEmail.text),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 90, 68, 223),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                )
              ),
            ),
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
            ListTile(
              leading: Icon(Icons.check),
              iconColor: Color.fromARGB(255, 90, 68, 223),
              focusColor: Color.fromARGB(255, 90, 68, 223),
              title: Text('영수증 검토',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                )
              ),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptList(submissionStatus: AppCore.getInstance().getUser().submissionStatusList)));
              }
            ),
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
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptList(submissionStatus: AppCore.getInstance().getUser().submissionStatusList)));
              },
            ),
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
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptCalculate(departmentId: AppCore.getInstance().getUser().departmentIdList)));
              },
            ),
            ListTile(
              leading: Icon(Icons.add_box_outlined),
              iconColor: Color.fromARGB(255, 90, 68, 223),
              focusColor: Color.fromARGB(255, 90, 68, 223),
              title: Text('예산 추가',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                )
              ),
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) => budgetAdd(departmentId: AppCore.getInstance().getUser().departmentIdList)));
              },
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      title: Column(children: <Widget>[Text('로그아웃')]),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[Text("로그아웃 하시겠습니까?",),],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {Navigator.pop(context);},
                          child: Text('취소'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            AppCore.instance.logOut();

                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => FirstRun()), (route) => false);
                          },
                          child: Text('확인'),
                        )
                      ],
                    );
                  }
                );
              },
              child: Text('로그아웃')
            ),
          ],
        ),
      ),
    );
  }
}