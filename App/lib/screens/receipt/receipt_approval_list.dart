import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/receipt/receipt_detail.dart';
import 'package:test/screens/screen_frame.dart';
import '../../models/department.dart';
import '../../models/receipt.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';

class ReceiptApprovalList extends StatefulWidget {
  const ReceiptApprovalList({super.key});

  @override
  State<ReceiptApprovalList> createState() => _ReceiptList();
}

List<Department> departmentList = <Department>[];

class _ReceiptList extends State<ReceiptApprovalList> {
  int selectDepartmentId = -1;
  String selectDepartmentName = '신청부서';
  int selectSubmissionStatus = 1;
  List<Receipt> receiptList = <Receipt>[];
  List<Receipt> filterReceiptList = <Receipt>[];

  @override
  void initState() {
    super.initState();

    departmentList = <Department>[];

    Department allDepartment = Department();
    allDepartment.departmentName = '신청부서';
    departmentList.add(allDepartment);
    departmentList.addAll(AppCore.instance.getUser().selectGroup.departmentList);

    setReceiptList();
  }

  void setReceiptList() async {
    List<Receipt> tempList = await getReceiptApprovalList();
    setState(()  {
      receiptList = tempList;
    });
    refreshFilterReceiptList();
  }

  void refreshFilterReceiptList() {
    if (selectDepartmentId == -1) {
      if (selectSubmissionStatus == 1) {
        filterReceiptList = receiptList.where((element) => element.submissionStatus == selectSubmissionStatus).toList();
      }
      else {
        filterReceiptList = receiptList.where((element) => element.submissionStatus >= selectSubmissionStatus).toList();
      }
    }
    else {
      if (selectSubmissionStatus == 1) {
        filterReceiptList = receiptList.where((element) => element.approvalRequestDepartmentId == selectDepartmentId && element.submissionStatus == selectSubmissionStatus).toList();
      }
      else {
        filterReceiptList = receiptList.where((element) => element.approvalRequestDepartmentId == selectDepartmentId && element.submissionStatus >= selectSubmissionStatus).toList();
      }
    }

    setState(() {
      filterReceiptList.sort((a, b) => a.paymentDatetime.compareTo(b.paymentDatetime));
    });
  }
  
  Future<List<Receipt>> getReceiptApprovalList() async {

    String address = '/getReceiptApprovalList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      List<Receipt> tempList = [];
      
      for (Map<String, dynamic> json in jsonDecode(responseData.body)) {
        Receipt receipt = Receipt();
        receipt.setData(json);
        
        tempList.add(receipt);
      }

      return tempList;
    }

    return [];
  }

  @override
  Widget build(BuildContext context){
    return ScreenFrame(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(
                text: '제출내역',
              ),
              Expanded(
                flex: 1,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          selectSubmissionStatus = 1;
                          refreshFilterReceiptList();
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                        ),
                        child: Text(
                          '미확인 ${receiptList.where((element) => element.submissionStatus == 1 && (selectDepartmentId != -1 ? element.approvalRequestDepartmentId == selectDepartmentId : true)).length}',
                          style: TextStyle(
                            color: selectSubmissionStatus == 1 ? Colors.black : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '|'
                    ),
                    Expanded(
                      flex: 2,
                      child: TextButton(
                        onPressed: () {
                          selectSubmissionStatus = 2;
                          refreshFilterReceiptList();
                        },
                        style: ButtonStyle(
                          overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                        ),
                        child: Text(
                          '확인 ${receiptList.where((element) => element.submissionStatus > 1 && (selectDepartmentId != -1 ? element.approvalRequestDepartmentId == selectDepartmentId : true)).length}',
                          style: TextStyle(
                            color: selectSubmissionStatus == 2 ? Colors.black : Colors.black38,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 3,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        value: selectDepartmentName,
                        items: departmentList.map(
                          (value) { 
                            return DropdownMenuItem<String>(
                              value: value.departmentName,
                              child: Text(value.departmentName),
                              );
                            },
                          ).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectDepartmentId = departmentList.firstWhere((department) => department.departmentName == value).departmentId;
                            selectDepartmentName = departmentList.firstWhere((department) => department.departmentName == value).departmentName;
                            refreshFilterReceiptList();
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15),),
                            borderSide: BorderSide(
                              color: Colors.black26,
                              width: 2,
                            ),
                          ),
                          contentPadding: EdgeInsets.fromLTRB(10, 1, 1, 1),
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
                  itemCount: filterReceiptList.length,
                  itemBuilder: (BuildContext context, int index) {
                    Receipt receipt = filterReceiptList[index];

                    return GestureDetector(
                      onTap: () async {
                        await Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptDetail(receipt: receipt, authLevel: AuthLevel.approval,)),).then((value) {
                          if (value == true) {
                            getReceiptApprovalList();
                            refreshFilterReceiptList();
                          }
                        });
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
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 4,
                                          child: Text(
                                            receipt.title,
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
                                  ),
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Text(
                                            receipt.requestUserName,
                                            style: TextStyle(
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 8,
                                          child: Text(
                                            receipt.paymentDatetime.substring(0, 16),
                                            style: TextStyle(
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SizedBox(),
                                        ),
                                        Expanded(
                                          flex: 5,
                                          child: Text(
                                            '${NumberFormat('#,###').format(receipt.requestAmount)}원',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    );
                  }
                )
              ),
            ]
          )
        )
      )
    );
  }
}