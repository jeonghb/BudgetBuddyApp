import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  List<PositionRequest> positionRequestFilterList = <PositionRequest>[];
  int selectApprovalStatus = 1;

  @override
  void initState() {
    super.initState();

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
        positionRequestFilterList = positionRequestList;
      });

      filterPositionRequestList();
    }
  }

  void filterPositionRequestList() {
    for (PositionRequest positionRequest in positionRequestList) {
      positionRequest.isCheck = false;
    }

    if (selectApprovalStatus == 1) {
      setState(() {
        positionRequestFilterList = positionRequestList.where((element) => element.approvalStatus == selectApprovalStatus).toList();
      });
    }
    else if (selectApprovalStatus == 2) {
      setState(() {
        positionRequestFilterList = positionRequestList.where((element) => element.approvalStatus >= selectApprovalStatus).toList();
      });
    }
  }

  void allCheck(bool isCheck) {
    for (PositionRequest positionRequest in positionRequestFilterList) {
      setState(() {
        positionRequest.isCheck = isCheck;
      });
    }
  }

  Future<bool> positionRequestApproval(bool approvalType) async {
    int failCount = 0;

    for (PositionRequest positionRequest in positionRequestFilterList) {
      if (!positionRequest.isCheck) continue;

      if (approvalType) {
        positionRequest.approvalStatus = 2;
      }
      else {
        positionRequest.approvalStatus = 0;
      }

      if (await positionRequest.requestFinish() == false) {
        failCount++;
      }
    }

    if (failCount > 0) {
      return false;
    }

    return true;
  }
  
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TitleText(
              text: '직책 신청 정보',
            ),
            SizedBox(
              height: 35,
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          selectApprovalStatus = 1;
                          filterPositionRequestList();
                        });
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                      ),
                      child: Text(
                        '미확인 ${positionRequestList.where((element) => element.approvalStatus == 1).length}',
                        style: TextStyle(
                          color: selectApprovalStatus == 1 ? Colors.black : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '|'
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        selectApprovalStatus = 2;
                        filterPositionRequestList();
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                      ),
                      child: Text(
                        '확인 ${positionRequestList.where((element) => element.approvalStatus > 1).length}',
                        style: TextStyle(
                          color: selectApprovalStatus == 2 ? Colors.black : Colors.black38,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 35,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: SizedBox(),
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        allCheck(true);
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                      ),
                      icon: Icon(
                        Icons.check,
                        size: 14,
                        color: Colors.grey,
                      ),
                      label: Text(
                        '전체',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    '|'
                  ),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        allCheck(false);
                      },
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                      ),
                      icon: Icon(
                        Icons.refresh,
                        size: 14,
                        color: Colors.grey,
                      ),
                      label: Text(
                        '해제',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: positionRequestFilterList.length,
                itemBuilder: (BuildContext context, int index) {
                  final positionRequest = positionRequestFilterList[index];

                  return GestureDetector(
                    onTap: () async {
                      setState(() {
                        positionRequest.isCheck = !positionRequest.isCheck;
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(
                              color: positionRequest.isCheck ? Color.fromARGB(255, 90, 68, 223) : Colors.grey,
                              width: 1,
                            )
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(5, 10, 10, 5),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: positionRequest.isCheck ? Color.fromARGB(255, 90, 68, 223) : Colors.grey[600],
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Text(
                                          positionRequest.requestUserName,
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: TextButton(
                                          onPressed: () async {
                                            await Navigator.push(context, MaterialPageRoute(builder: (context) => PositionRequestManage(positionRequest: positionRequest,)),).then((value) {
                                              getPositionRequestList();
                                            });
                                          },
                                          style: TextButton.styleFrom(
                                            padding: EdgeInsets.fromLTRB(8, 0, 8, 2),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20)
                                            ),
                                            backgroundColor: Colors.blue[100],
                                          ),
                                          child: Text(
                                            '상세보기',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.blue[600],
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '생년월일 | ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          positionRequest.requestUserBirthday,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: SizedBox(),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: SizedBox(),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Text(
                                          '신청직책 | ',
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          positionRequest.requestPositionName,
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: SizedBox(),
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
                    AppCore.showMessage(context, '직책 승인', '선택한 대상을 모두 승인처리하시겠습니까?', ActionType.yesNo, () async {
                      Navigator.pop(context);

                      if (!await positionRequestApproval(true)) {
                        // ignore: use_build_context_synchronously
                        AppCore.showMessage(context, '직책 승인', '승인되지 않은 항목이 있습니다.', ActionType.ok, () {
                          Navigator.pop(context);
                        });
                      }
                      else {
                        // ignore: use_build_context_synchronously
                        AppCore.showMessage(context, '직책 승인', '승인 완료', ActionType.ok, () {
                          Navigator.pop(context);
                        });
                      }

                      getPositionRequestList();
                    });
                  },
                  child: Text(
                    '승인',
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
        )
      ),
    );
  }
}