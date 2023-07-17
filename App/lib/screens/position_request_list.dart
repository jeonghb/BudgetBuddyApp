import 'package:flutter/material.dart';
import '../models/position_request.dart';
import 'screen_frame.dart';

class PositionRequestList extends StatefulWidget {
  const PositionRequestList({super.key});

  @override
  State<PositionRequestList> createState() => _PositionRequestList();
}

class _PositionRequestList extends State<PositionRequestList> {
  List<PositionRequest> positionRequestList = <PositionRequest>[];

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '직책 신청 목록',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          ListView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            itemCount: positionRequestList.length,
            itemBuilder: (BuildContext context, int index) {
              final positionRequest = positionRequestList[index];

              return GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => positionRequestManage(positionRequest: positionRequest,)),);
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