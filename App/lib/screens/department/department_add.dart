import 'package:flutter/material.dart';
import 'package:test/widgets/text_form_field_v1.dart';

import '../../app_core.dart';
import '../../models/response_data.dart';
import '../screen_frame.dart';

class DepartmentAdd extends StatefulWidget {
  const DepartmentAdd({super.key});

  @override
  State<DepartmentAdd> createState() => _DepartmentAdd();
}

class _DepartmentAdd extends State<DepartmentAdd> {
  TextEditingController departmentName = TextEditingController();

  String setData() {
    if (departmentName.text.isEmpty) {
      return '부서명이 입력되지 않았습니다.';
    }

    return '';
  }

  Future<bool> departmentAdd() async {
    String address = '/departmentAdd';
    Map<String, dynamic> body = {
      'departmentName' : departmentName.text,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      if (responseData.body.toString() == 'true') {
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
    return ScreenFrame(
      body: Column(
        children: [
          Text(
            '부서 추가',
          ),
          TextFormFieldV1(
            controller: departmentName,
          ),
          TextButton(
            onPressed: () async {
              String validationMessage = setData();
              if (validationMessage.isEmpty) {
                if (await departmentAdd()) {
                  // ignore: use_build_context_synchronously
                  showDialog(
                    context: context, 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        title: Column(children: const <Widget>[Text('부서 추가')]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[Text("부서 추가 완료",),],
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
                        title: Column(children: const <Widget>[Text('부서 추가')]),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const <Widget>[Text("부서 추가 실패. 해당 부서명이 추가되어 있는지 확인하세요.",),],
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
              }
              else {
                // ignore: use_build_context_synchronously
                showDialog(
                  context: context, 
                  builder: (BuildContext context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      title: Column(children: const <Widget>[Text('부서 추가')]),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[Text(validationMessage,),],
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
            },
            child: Text(
              '추가',
            ),
          ),
        ],
      ),
    );
  }
}