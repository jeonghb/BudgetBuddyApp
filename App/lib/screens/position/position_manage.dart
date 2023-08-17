import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../app_core.dart';
import '../../models/Position.dart';
import '../../models/auth.dart';
import '../../models/response_data.dart';
import '../../widgets/text_form_field_v1.dart';
import '../screen_frame.dart';

class PositionManage extends StatefulWidget {
  final Position position;
  const PositionManage({super.key, required this.position});

  @override
  State<PositionManage> createState() => _PositionManage();
}

class _PositionManage extends State<PositionManage> {
  TextEditingController positionName = TextEditingController();

  @override
  void initState() {
    super.initState();

    getAuthList();
  }

  void getAuthList() async {
    String address = '/getAuthList';
    Map<String, dynamic> body = {
    };

    ResponseData responseData = await AppCore.request(ServerType.GET, address, body);

    if (responseData.statusCode == 200) {
      for (var json in jsonDecode(responseData.body))
      {
        Auth auth = Auth.fromJson(json);

        if (widget.position.authList.firstWhereOrNull((element) => element.authId == auth.authId) == null) {
          widget.position.authList.add(auth);
        }
      }
    }
  }

  void save(bool positionActivationStatus) async {
    if (widget.position.positionName.isEmpty) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(children: const <Widget>[Text('직책 정보 수정')]),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[Text('직책명이 입력되지 않았습니다.',),],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('확인'), 
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
      return;
    }

    widget.position.positionName = positionName.text;
    widget.position.positionActivationStatus = positionActivationStatus;

    if (await widget.position.positionUpdate()) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(children: const <Widget>[Text('직책 정보 수정')]),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[Text('직책 정보 저장 성공',),],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('확인'), 
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }
    else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(children: const <Widget>[Text('직책 정보 수정')]),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[Text('저장 실패. 직책명이 해당 부서에서 사용되고 있는지 확인하세요.',),],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('확인'), 
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        },
      );
    }
    return ;
  }

  @override
  Widget build(BuildContext context) {
    positionName.text = widget.position.positionName;

    return ScreenFrame(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Text(
                  '직책 정보',
                ),
                Text(
                  '부서'
                ),
                Text(
                  widget.position.departmentName,
                ),
                TextFormFieldV1(
                  controller: positionName,
                ),
                Text(
                  '권한 설정',
                ),
                ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.position.authList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final auth = widget.position.authList[index];

                    return ListTile(
                      title: Text(
                        auth.authName,
                      ),
                      trailing: Checkbox(
                        value: widget.position.authList.firstWhere((element) => element.authId == auth.authId).use,
                        onChanged: (newValue) {
                          setState(() {
                            widget.position.authList.firstWhere((element) => element.authId == auth.authId).use = newValue!;
                          });
                        },
                      ),
                    );
                  }
                ),
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                TextButton(
                  onPressed: () async {
                    save(widget.position.positionActivationStatus);
                  },
                  child: Text(
                    '저장',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    save(!widget.position.positionActivationStatus);
                  },
                  child: Text(
                    widget.position.positionActivationStatus ? '미사용' : '사용',
                  ),
                ),
              ],
            )
          ),
        ]
      ),
    );
  }
}