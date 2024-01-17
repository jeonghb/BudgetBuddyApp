import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_core.dart';
import '../../models/position.dart';
import '../../models/auth.dart';
import '../../models/response_data.dart';
import '../../widgets/text_form_field_v1.dart';
import '../../widgets/title_text.dart';
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

    positionName.text = widget.position.positionName;

    getAuthList();
  }

  void getAuthList() async {
    String address = '/getPositionAuthList';
    Map<String, dynamic> body = {
      'positionId': widget.position.positionId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      List<Auth> tempList = <Auth>[];
      for (var json in jsonDecode(responseData.body))
      {
        Auth auth = Auth();
        auth.setData(json);

        tempList.add(auth);
      }

      setState(() {
        widget.position.positionAuthList = tempList;
      });
    }
  }

  void save(bool positionActivationStatus) async {
    if (widget.position.positionName.isEmpty) {
      AppCore.showMessage(context, '직책 정보 수정', '직책명이 입력되지 않았습니다', ActionType.ok, () {
        Navigator.pop(context);
      });

      return;
    }

    widget.position.positionName = positionName.text;
    widget.position.positionActivationStatus = positionActivationStatus;

    if (await widget.position.positionUpdate()) {
      // ignore: use_build_context_synchronously
      AppCore.showMessage(context, '직책 정보 수정', '저장 완료', ActionType.ok, () {
        Navigator.pop(context);
        Navigator.pop(context, true);
      });
    }
    else {
      // ignore: use_build_context_synchronously
      AppCore.showMessage(context, '직책 정보 수정', '저장 실패. 직책명이 해당 부서에서 사용되고 있는지 확인하세요', ActionType.ok, () {
        Navigator.pop(context);
      });
    }
    
    return ;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: '직책 정보',
                    ),
                    Text(
                      '부서명',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '  ${widget.position.departmentName}',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '직책명',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormFieldV1(
                      controller: positionName,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '권한 설정',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      physics: ScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: widget.position.positionAuthList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final auth = widget.position.positionAuthList[index];

                        return ListTile(
                          title: Text(
                            auth.authName,
                          ),
                          trailing: Checkbox(
                            value: widget.position.positionAuthList.firstWhere((element) => element.authId == auth.authId).use,
                            onChanged: (newValue) {
                              setState(() {
                                widget.position.positionAuthList.firstWhere((element) => element.authId == auth.authId).use = newValue!;
                              });
                            },
                          ),
                        );
                      }
                    ),
                  ],
                )
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(130),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                        onPressed: () async {
                          save(!widget.position.positionActivationStatus);
                        },
                        child: Text(
                          widget.position.positionActivationStatus ? '미사용' : '사용',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: SizedBox(
                      width: double.infinity,
                      height: ScreenUtil().setHeight(130),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 90, 68, 223),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                        ),
                        onPressed: () async {
                          save(widget.position.positionActivationStatus);
                        },
                        child: Text(
                          '저장',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}