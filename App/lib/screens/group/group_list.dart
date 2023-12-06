import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/models/group.dart';
import 'package:test/widgets/text_form_field_v1.dart';
import 'package:test/widgets/title_text.dart';

import '../../app_core.dart';
import '../../models/response_data.dart';
import 'group_introduce.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupList();
}

class _GroupList extends State<GroupList> {
  List<Group> groupList = <Group>[];
  TextEditingController searchText = TextEditingController();

  Future<void> getGroupList() async {
    if (searchText.text.isEmpty) return;
    
    String address = '/getGroupList';
    Map<String, dynamic> body = {
      'searchText': searchText.text,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      List<Group> tempList = <Group>[];

      for (var json in jsonDecode(responseData.body)) {
        Group group = Group();
        group.setData(json);
        tempList.add(group);
      }

      setState(() {
        groupList = tempList;
      });
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
            SizedBox(
              height: 50,
            ),
            TitleText(
              text: '그룹 검색',
            ),
            TextFormFieldV1(
              controller: searchText,
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () => getGroupList(),
              ),
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                getGroupList(); 
              },
              textInputAction: TextInputAction.done,
            ),
            Expanded(
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: groupList.length,
                itemBuilder: (BuildContext context, int index) {
                  final group = groupList[index];

                  return GestureDetector(
                    onTap: () async {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => GroupIntroduce(group: group,)),);
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
                                        flex: 3,
                                        child: Text(
                                          group.groupName,
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
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.person,
                                                size: 14,
                                              ),
                                              Text(
                                                '  ${group.groupUserCount.toString()}',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      group.groupIntroduceMemo,
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
                      ],
                    )
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}