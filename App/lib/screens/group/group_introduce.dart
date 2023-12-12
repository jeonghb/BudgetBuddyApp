import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/screens/screen_frame.dart';
import 'package:test/widgets/top_bar.dart';

import '../../app_core.dart';
import '../../models/group.dart';
import '../../models/response_data.dart';
import '../home.dart';

class GroupIntroduce extends StatefulWidget {
  final Group group;

  const GroupIntroduce({super.key, required this.group,});

  @override
  State<GroupIntroduce> createState() => _GroupIntroduce();
}

class _GroupIntroduce extends State<GroupIntroduce> {
  Future<bool> groupRegist() async {
    String address = '/groupRegist';
    Map<String, dynamic> body = {
      'groupId': widget.group.groupId,
      'userId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    try {
        if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
        Group group = Group();
        group.setData(jsonDecode(responseData.body));
        
        AppCore.instance.getUser().groupList.add(group);
        AppCore.instance.getUser().selectGroupId = group.groupId;
        return true;
      }
      else {
        return false;
      }
    }
    catch (e) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      appBarType: AppCore.instance.getUser().selectGroupId != -1 ? BarType.exit : BarType.exit,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.group.groupName,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.person,
                          size: 14,
                        ),
                        Text(
                          '  ${widget.group.groupUserCount.toString()}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.group.groupIntroduceMemo,
                    ),
                  ]
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(130),
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 90, 68, 223)),
                ),
                onPressed: () async {
                  if (AppCore.instance.getUser().groupList.any((group) => group.groupId == widget.group.groupId)) {
                    AppCore.showMessage(context, '그룹 가입', '이미 가입된 그룹입니다.', ActionType.ok, () {
                      Navigator.pop(context);
                    });
                    return;
                  }

                  if (await groupRegist()) {
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '그룹 가입', '가입 완료', ActionType.ok, () {
                      Navigator.pop(context);
                    });
                    
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(groupId: AppCore.instance.getUser().groupList[0].groupId)), (route) => false,);
                  }
                  else {
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '그룹 가입', '그룹 가입에 실패했습니다.', ActionType.ok, () {
                      Navigator.pop(context);
                    });
                  }
                },
                child: Text(
                  '가입',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}