import 'dart:convert';

import 'package:flutter/material.dart';

import '../../app_core.dart';
import '../../models/position.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';
import 'position_manage.dart';

class PositionList extends StatefulWidget {
  const PositionList({super.key});

  @override
  State<PositionList> createState() => _PositionList();
}

class _PositionList extends State<PositionList> {
  List<Position> positionList = <Position>[];

  @override
  void initState() {
    super.initState();

    getPositionList();
  }

  void getPositionList() async {
    String address = '/getPositionList';
    Map<String, dynamic> body = {
    };

    ResponseData responseData = await AppCore.request(ServerType.GET, address, body);

    if (responseData.statusCode == 200) {
      List<Position> tempList = <Position>[];
      
      for (var json in jsonDecode(responseData.body))
      {
        Position position = Position();
        position.setData(json);

        tempList.add(position);
      }

      setState(() {
        positionList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Expanded(
        child: Column(
          children: [
            TitleText(
              text: '직책 목록',
            ),
            ListView.builder(
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemCount: positionList.length,
              itemBuilder: (BuildContext context, int index) {
                final position = positionList[index];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PositionManage(position: position,)),).then((value) {
                      if (value == true) {
                        getPositionList();
                      }
                    });
                  },
                  child: Column (
                    children: [
                      ListTile(
                        leading: Text('${position.departmentName},${position.positionName}'),
                        
                      ),
                      Divider(),
                    ]
                  ),
                );
              }
            )
          ],
        ),
      ),
    );
  }
}