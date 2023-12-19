import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/widgets/title_text.dart';
import 'package:test/widgets/top_bar.dart';

import '../../models/group.dart';
import '../screen_frame.dart';

class MyGroupList extends StatefulWidget {
  const MyGroupList({super.key});

  @override
  State<MyGroupList> createState() => _MyGroupList();
}

class _MyGroupList extends State<MyGroupList> {
  List<Group> groupList = AppCore.instance.getUser().groupList;

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      appBarType: BarType.exit,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            TitleText(
              text: '그룹 전환',
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
                      AppCore.instance.getUser().selectGroupId = group.groupId;
                      Navigator.pop(context, true);
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
                            child: Expanded(
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 7,
                                    child: Text(
                                      group.groupName,
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: group.groupId == AppCore.instance.getUser().selectGroupId ? Icon(
                                        Icons.check_circle,
                                        color: Color.fromARGB(255, 90, 68, 223),
                                      ) : null,
                                    ),
                                  ),
                                ],
                              ),
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
      ),
    );
  }
}