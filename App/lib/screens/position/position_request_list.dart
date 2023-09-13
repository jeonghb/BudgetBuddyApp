import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/models/response_data.dart';
import '../../models/position_request.dart';
import '../../widgets/title_text.dart';
import 'position_request_manage.dart';
import '../screen_frame.dart';

class PositionRequestList extends StatefulWidget {
  const PositionRequestList({super.key});

  @override
  State<PositionRequestList> createState() => _PositionRequestList();
}

class _PositionRequestList extends State<PositionRequestList> {
  List<PositionRequest> positionRequestList = <PositionRequest>[];

  @override
  void initState() {
    super.initState();

    positionRequestList.add(PositionRequest());

    getPositionRequestList();
  }

  void getPositionRequestList() async {
    String address = '/getPositionRequestList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId.text,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      List<PositionRequest> tempList = <PositionRequest>[];

      for (var json in jsonDecode(responseData.body))
      {
        PositionRequest positionRequest = PositionRequest();
        positionRequest.setData(json);

        tempList.add(positionRequest);
      }

      setState(() {
        positionRequestList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          TitleText(
            text: '직책 신청 목록',
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: positionRequestList.length,
            itemBuilder: (BuildContext context, int index) {
              final positionRequest = positionRequestList[index];

              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PositionRequestManage(positionRequest: positionRequest,)),).then((value) {
                    if (value == true) {
                      getPositionRequestList();
                    }
                  });
                },
                child: Column (
                  children: [
                    ListTile(
                      leading: Text(positionRequest.requestUserName),
                      
                    ),
                    Divider(),
                  ]
                ),
              );
            }
          )
        ]
      )
    );
  }
}