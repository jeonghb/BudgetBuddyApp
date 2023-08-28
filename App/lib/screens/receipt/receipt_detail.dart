import 'dart:io';
import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/receipt/receipt_request.dart';
import 'package:test/widgets/top_bar.dart';
import '../../models/receipt.dart';
import '../../widgets/menu_drawer.dart';

enum AuthLevel {
  view,
  approval,
}

class ReceiptDetail extends StatefulWidget {
  final Receipt receipt;
  final AuthLevel authLevel;

  const ReceiptDetail({super.key, required this.receipt, required this.authLevel});

  @override
  State<ReceiptDetail> createState() => _ReceiptDetail();
}


class _ReceiptDetail extends State<ReceiptDetail> {
  TextEditingController rejectMessage = TextEditingController();

  void showImage(int index) {
  }

  @override
  Widget build(BuildContext context){
    final receipt = widget.receipt;
    final authLevel = widget.authLevel;

    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        appBar: TopBar(type: BarType.login),
        endDrawer: MenuDrawer(),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text('제목',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(receipt.title,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('결제금액',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(receipt.requestAmount.toString(),
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text('메모',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(receipt.memo,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ]
                  ),
                  Row(
                    children: <Widget>[
                      Text('결제일시',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(receipt.paymentDatetime,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ]
                  ),
                  Row(
                    children: <Widget>[
                      Text('구분',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(receipt.budgetTypeName,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ]
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: 300,
                    height: 100,
                    child: GridView.builder(
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: receipt.fileList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            showImage(index);
                          },
                          child: Image.file(
                            File(receipt.fileList[index].path),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  Row(
                    children: const <Widget>[
                      Text('계좌번호',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text('1002-340-513599 우리은행',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ]
                  ),
                  if (authLevel == AuthLevel.approval)
                    Row(
                      children: <Widget>[
                        TextButton(
                          onPressed: () {
                            List<Widget> widgets = <Widget>[
                              Text('반려 사유'),
                              TextFormField(
                                controller: rejectMessage,
                                maxLines: null,
                                decoration: InputDecoration(
                                  hintText: '반려 사유를 입력하세요.',
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                                ),
                              )
                            ];
                            AppCore.showMessage(context, '반려', '', ActionType.yesNo, () {
                              Navigator.pop(context);
                              receipt.submissionStatus = 0;
                              receipt.rejectMessage = rejectMessage.text;
                              receipt.changeSubmissionStatus().then((bool result) {
                                if (result) {
                                  Navigator.pop(context);
                                }
                                else {
                                  AppCore.showMessage(context, '반려', '반려 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                                    Navigator.pop(context);
                                  });
                                }
                              });
                              Navigator.pop(context);
                            },
                            widgets: widgets);
                          },
                          child: Text('반려')
                        ),
                        TextButton(
                          onPressed: () {
                            AppCore.showMessage(context, '결재', '결재하시겠습니까?', ActionType.yesNo, () {
                              Navigator.pop(context);
                              receipt.submissionStatus = 2;
                              receipt.changeSubmissionStatus().then((bool result) {
                                if (result) {
                                  Navigator.pop(context);
                                }
                                else {
                                  AppCore.showMessage(context, '결재', '결재 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                                    Navigator.pop(context);
                                  });
                                }
                              });
                              Navigator.pop(context);
                            });
                          },
                          child: Text('결재')
                        ),
                        TextButton(
                          onPressed: () {
                            AppCore.showMessage(context, '송금완료', '송금완료 처리하시겠습니까?', ActionType.yesNo, () {
                              Navigator.pop(context);
                              receipt.submissionStatus = 3;
                              receipt.changeSubmissionStatus().then((bool result) {
                                if (result) {
                                  Navigator.pop(context);
                                }
                                else {
                                  AppCore.showMessage(context, '송금완료', '송금완료 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                                    Navigator.pop(context);
                                  });
                                }
                              });
                              Navigator.pop(context);
                            });
                          },
                          child: Text('송금완료')
                        ),
                      ],
                    )
                  else if (authLevel == AuthLevel.view)
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequest(receipt: receipt)),);
                      }, 
                      child: Text('수정하기')
                    )
                ]
              )
            )
          )
        )
      )
    );
  }
}