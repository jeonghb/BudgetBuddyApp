import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_core.dart';
import '../models/receipt.dart';
import '../screens/group/group_main.dart';
import '../screens/home.dart';
import '../screens/receipt/receipt_request.dart';
import '../screens/receipt/receipt_request_list.dart';
import '../screens/user/my_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
  });

  @override
  State<BottomBar> createState() => _BottomBar();
}

class _BottomBar extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: ScreenUtil().setHeight(130),
      child: Column(
        children: [
          Divider(
            color: Colors.grey,
            thickness: 1,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.popUntil(context, (route) => route.settings.name == '/Home');
                    
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequest(receipt: Receipt(),)),);
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/bottomNavigationBarReceiptRequest.png'),
                      Text(
                        '영수증 제출',
                      )
                    ],
                  ),
                )
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequestList()),);
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/bottomNavigationBarReceiptRequestList.png'),
                      Text(
                        '제출내역',
                      )
                    ],
                  ),
                )
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(groupId: AppCore.instance.getUser().selectGroup.groupId)), (route) => false,);
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/bottomNavigationBarHome.png'),
                      Text(
                        'Home',
                      )
                    ],
                  ),
                )
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => GroupMain()),);
                  },
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 20,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(255, 90, 68, 223),
                        ),
                        child: Center(
                          child: Text(
                            AppCore.instance.getUser().selectGroup.groupName.substring(0, 1),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        '그룹관리',
                      ),
                    ],
                  ),
                )
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MyPage()));
                  },
                  child: Column(
                    children: [
                      Image.asset('assets/images/bottomNavigationBarMyPage.png'),
                      Text(
                        '마이페이지',
                      )
                    ],
                  ),
                )
              ),
            ]
          ),
        ]
      ),
    );
  }
}