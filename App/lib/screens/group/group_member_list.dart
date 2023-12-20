import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/widgets/title_text.dart';

import '../../app_core.dart';
import '../../models/group_member.dart';
import '../../models/response_data.dart';
import '../../widgets/text_form_field_v1.dart';
import '../../widgets/top_bar.dart';
import '../screen_frame.dart';
import 'group_member_detail.dart';

class GroupMemberList extends StatefulWidget {
  const GroupMemberList({super.key});

  @override
  State<GroupMemberList> createState() => _GroupMemberList();
}

class _GroupMemberList extends State<GroupMemberList> {
  List<GroupMember> groupMemberList = <GroupMember>[];
  TextEditingController searchText = TextEditingController();

  @override
  void initState() {
    super.initState();

    getGroupMemberList();
  }

  Future<void> getGroupMemberList() async {
    String address = '/getGroupMemberList';
    Map<String, dynamic> body = {
      'groupId': AppCore.instance.getUser().selectGroup.groupId,
      'searchText': searchText.text,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      List<GroupMember> tempList = <GroupMember>[];

      for (var json in jsonDecode(responseData.body)) {
        GroupMember groupMember = GroupMember();
        groupMember.setData(json);
        tempList.add(groupMember);
      }

      tempList = tempList.where((groupMember) => groupMember.userId != AppCore.instance.getUser().userId).toList();

      setState(() {
        groupMemberList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      appBarType: BarType.exit,
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
                onPressed: () => getGroupMemberList(),
              ),
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                getGroupMemberList(); 
              },
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: groupMemberList.length,
                itemBuilder: (BuildContext context, int index) {
                  final groupMember = groupMemberList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => GroupMemberDetail(groupMember: groupMember,)),);
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
                                          groupMember.userName,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          groupMember.userBirthday,
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
                                            '상세보기',
                                            style: TextStyle(
                                              fontSize: 12,
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
          ]
        )
      )
    );
  }
}