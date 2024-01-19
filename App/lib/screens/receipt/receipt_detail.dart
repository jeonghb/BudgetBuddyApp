import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import '../../app_core.dart';
import '../../models/response_data.dart';
import 'receipt_request.dart';
import '../../widgets/receipt_data.dart';
import '../../widgets/title_text.dart';
import '../../models/receipt.dart';
import '../screen_frame.dart';

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
  List<Map<int, String>> approvalList = <Map<int, String>>[
    {0: '반려'},
    {1: '신청'},
    {2: '결재'},
    {3: '송금'},
  ];
  int selectApprovalId = 2;

  @override
  void initState() {
    super.initState();

    if (widget.receipt.fileNameList.isNotEmpty) {
      getFileList();
    }

    // 현재 상태값 다음으로 변경할 수 있도록 세팅(단 송금(3) 보다 클 수 없음)
    selectApprovalId = widget.receipt.submissionStatus + 1 > 3 ? widget.receipt.submissionStatus : widget.receipt.submissionStatus + 1;
  }

  void getFileList() async {
    String address = '/getFileList';
    Map<String, dynamic> body = {
      'fileNameList': widget.receipt.fileNameList,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      List<XFile> tempList = <XFile>[];

      for (Map<String, dynamic> fileData in jsonDecode(responseData.body))
      {
          if (fileData.containsKey('bytes') && fileData.containsKey('name')) {
          var bytes = base64Decode(fileData['bytes']);
          var fileName = fileData['name'];

          // Save the bytes to a file
          Directory tempDir = await getTemporaryDirectory();
          File file = File('${tempDir.path}/$fileName');
          await file.writeAsBytes(bytes);

          // Create XFile from the file path
          var xFile = XFile(file.path);

          tempList.add(xFile);
        }
      }

      setState(() {
        widget.receipt.fileList = tempList;
      });
    }
  }

  void showImage(BuildContext context, File file) {
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Image.file(file),
          ),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context){
    Receipt receipt = widget.receipt;

    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(
                text: '영수증 정보',
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Text(
                      receipt.title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: receipt.submissionStatus == 0 ? Colors.red[100] :  receipt.submissionStatus == 1 ? Colors.purple[100] : receipt.submissionStatus == 2 ? Colors.blue[100] : Colors.green[100],
                      ),
                      child: Text(
                        receipt.submissionStatus == 0 ? '반려' : receipt.submissionStatus == 1 ? '미확인' : receipt.submissionStatus == 2 ? '결재' : '송금',
                        style: TextStyle(
                          color: receipt.submissionStatus == 0 ? Colors.red[400] : receipt.submissionStatus == 1 ? Colors.purple[400] : receipt.submissionStatus == 2 ? Colors.blue[400] : Colors.green[400],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ReceiptData(
                title: '결제금액',
                data: '${NumberFormat('#,###').format(receipt.requestAmount)}원',
              ),
              SizedBox(
                height: 10,
              ),
              ReceiptData(
                title: '메모',
                data: receipt.memo,
              ),
              SizedBox(
                height: 10,
              ),
              ReceiptData(
                title: '결제일시',
                data: receipt.paymentDatetime.substring(0, 16),
              ),
              SizedBox(
                height: 10,
              ),
              ReceiptData(
                title: '구분',
                data: receipt.budgetTypeName,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      '사진',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemCount: widget.receipt.fileList.length,
                        itemBuilder: (BuildContext context, int index) {
                          final file = widget.receipt.fileList.isNotEmpty ? widget.receipt.fileList[index] : null;
                          return GestureDetector(
                            onTap: () {
                              if (file != null) {
                                showImage(context, File(file.path));
                              }
                            },
                            child: Image.file(
                              File(receipt.fileList[index].path),
                              fit: BoxFit.cover,
                            ),
                          );
                        }
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              ReceiptData(
                title: '계좌번호',
                data: '${receipt.bankName}(${receipt.requestUserName})',
              ),
              ReceiptData(
                title: '',
                data: receipt.bankAccountNumber,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      '결재상태',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black38,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: widget.authLevel == AuthLevel.approval ? DropdownButtonFormField<int>(
                      isExpanded: true,
                      value: selectApprovalId,
                      items: approvalList.map(
                        (Map<int, String> item) { 
                          int key = item.keys.first;
                          String value = item.values.first;

                          return DropdownMenuItem<int>(
                            value: key,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                      onChanged: (int? newValue) {
                        setState(() {
                          selectApprovalId = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10),),
                          borderSide: BorderSide(
                            color: Colors.black26,
                            width: 2,
                          ),
                        ),
                        contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 1),
                      ),
                    ) :
                    Text(
                      approvalList.firstWhere((element) => element.containsKey(receipt.submissionStatus), orElse: () => {-1: ''}).values.first
                       + (receipt.submissionStatus == 0 && receipt.rejectMessage.isNotEmpty ? '(${receipt.rejectMessage})' : ''),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(130),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: widget.authLevel == AuthLevel.view && receipt.submissionStatus > 1 ? Colors.grey : Color.fromARGB(255, 90, 68, 223),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  onPressed: widget.authLevel == AuthLevel.view && receipt.submissionStatus > 1 ? null : () async {
                    if (widget.authLevel == AuthLevel.approval) {
                      List<Widget>? widgets;
                      String title = '';
                      
                      if (selectApprovalId == 0) {
                        widgets = <Widget>[
                          Text('반려 사유'),
                          TextFormField(
                            controller: rejectMessage,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: '반려 사유를 입력하세요',
                              contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                            ),
                          )
                        ];
                        title = '반려';
                      }
                      else if (selectApprovalId == 1) {
                        title = '신청';
                      }
                      else if (selectApprovalId == 2) {
                        title = '결재';
                      }
                      else if (selectApprovalId == 3) {
                        title = '송금완료';
                      }
                      AppCore.showMessage(context, title, '$title 처리하시겠습니까?', ActionType.yesNo, () {
                        Navigator.pop(context);
                        receipt.submissionStatus = selectApprovalId;
                        receipt.rejectMessage = rejectMessage.text;
                        receipt.changeSubmissionStatus().then((bool result) {
                          if (result) {
                            Navigator.pop(context, true);
                          }
                          else {
                            AppCore.showMessage(context, title, '$title 처리 중 오류가 발생하였습니다. 다시 시도해주세요', ActionType.ok, () {
                              Navigator.pop(context);
                            });
                          }
                        });
                      },
                      widgets: widgets);
                    }
                    else {
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptRequest(receipt: receipt)),).then((value) {
                        if (value == true) {
                          Receipt newReceipt = receipt;
                          setState(() {
                            receipt = newReceipt;
                          });
                        }
                      });
                    }
                  },
                  child: Text(
                    widget.authLevel == AuthLevel.approval ? '결재하기' : '수정하기',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ]
          )
        )
      )
    );
  }
}