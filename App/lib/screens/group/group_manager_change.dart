import 'dart:convert';

import 'package:flutter/material.dart';

import '../../app_core.dart';
import '../../initialize.dart';
import '../../models/group_user.dart';
import '../../models/response_data.dart';
import '../../widgets/text_form_field_v1.dart';
import '../../widgets/title_text.dart';

class GroupManagerChange extends StatefulWidget {
  const GroupManagerChange({super.key});

  @override
  State<GroupManagerChange> createState() => _GroupManagerChange();
}

class _GroupManagerChange extends State<GroupManagerChange> {
  List<GroupUser> userList = <GroupUser>[];
  List<GroupUser> userFilterList = <GroupUser>[];
  TextEditingController searchText = TextEditingController();

  @override
  void initState() {
    super.initState();

    getGroupUserList();
  }

  Future<void> getGroupUserList() async {
    String address = '/getGroupUserList';
    Map<String, dynamic> body = {
      'groupId': AppCore.instance.getUser().selectGroupId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      List<GroupUser> tempList = <GroupUser>[];

      for (var json in jsonDecode(responseData.body)) {
        GroupUser groupUser = GroupUser();
        groupUser.setData(json);
        tempList.add(groupUser);
      }

      setState(() {
        userList = tempList;

      });
    }
  }

  void filterUserist() {
    setState(() {
      userFilterList = userList.where((user) => user.userName.contains(searchText.text)).toList();      
    });
  }

  Future<bool> groupManagerChange(String userId) async {
    String address = '/groupManagerChange';
    Map<String, dynamic> body = {
      'groupId': AppCore.instance.getUser().selectGroupId,
      'userId': userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      if (responseData.body == 'true') {
        return true;
      }
      else {
        return false;
      }
    }
    else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '그룹 관리자 변경',
            ),
            TextFormFieldV1(
              controller: searchText,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () => filterUserist(),
              ),
              onEditingComplete: () => filterUserist(),
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: userFilterList.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = userFilterList[index];

                  return GestureDetector(
                    onTap: () async {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Initialize()), (route) => false,);
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(31, 0, 0, 0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          user.userName,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          color: Color.fromARGB(255, 90, 68, 223),
                                        ),
                                        child: TextButton(
                                          onPressed: () async {
                                            AppCore.showMessage(context, '관리자 변경', '${user.userName}님으로 관리자를 변경하시겠습니까?', ActionType.yesNo, () async {
                                              Navigator.pop(context);
                                              if (await groupManagerChange(user.userId)) {
                                                // ignore: use_build_context_synchronously
                                                AppCore.showMessage(context, '관리자 변경', '관리자가 변경되었습니다. 재시작합니다.', ActionType.ok, () {
                                                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Initialize()), (route) => false,);
                                                });
                                              }
                                              else {
                                                // ignore: use_build_context_synchronously
                                                AppCore.showMessage(context, '관리자 변경', '관리자 변경 실패', ActionType.ok, () => Navigator.pop(context));
                                              }
                                            });
                                          },
                                          child: Text(
                                            '변경',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                            ),
                                            textAlign: TextAlign.center,
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${user.userBirthday} ${user.userSex == 'male' ? '남' : '여'}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ]
                    )
                  );
                }
              ),
            ),
          ]
        )
      )
    );
  }
}