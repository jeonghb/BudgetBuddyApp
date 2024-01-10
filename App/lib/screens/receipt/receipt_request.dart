import 'dart:convert';
import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/widgets/top_bar.dart';
import '../../app_core.dart';
import '../../screens/screen_frame.dart';
import '../../widgets/dropdown_button_v1.dart';
import '../../widgets/text_form_field_v1.dart';
import '../../models/bank.dart';
import '../../models/budget_type.dart';
import '../../models/receipt.dart';
import '../../models/department.dart';
import '../../models/response_data.dart';
import '../../widgets/title_text.dart';

class ReceiptRequest extends StatefulWidget {
  final Receipt receipt;

  const ReceiptRequest({
    super.key,
    required this.receipt
  });

  @override
  State<ReceiptRequest> createState() => _ReceiptRequest();
}

class _ReceiptRequest extends State<ReceiptRequest> {
  DateTime date = DateTime.now();
  List<Department> departmentList = <Department>[];
  List<BudgetType> budgetTypeList = <BudgetType>[];
  List<Bank> bankList = <Bank>[];
  TextEditingController title = TextEditingController();
  TextEditingController requestAmount = TextEditingController();
  TextEditingController memo = TextEditingController();
  TextEditingController paymentDatetimeYear = TextEditingController();
  TextEditingController paymentDatetimeMonth = TextEditingController();
  TextEditingController paymentDatetimeDay = TextEditingController();
  TextEditingController paymentDatetimeHour = TextEditingController();
  TextEditingController paymentDatetimeMinute = TextEditingController();
  int approvalRequestDepartmentId = -1;
  String approvalRequestDepartmentName = '';
  int budgetTypeId = -1;
  String budgetTypeName = '';
  List<XFile> fileList = <XFile>[];
  String bankName = '';
  TextEditingController bankAccountNumber = TextEditingController();

  @override
  void initState() {
    super.initState();

    departmentList.add(Department());
    bankList.add(Bank());

    if (widget.receipt.requestId != -1) {
      setWidgetData();

      Department department = Department();
      department.departmentId = approvalRequestDepartmentId;
      department.departmentName = approvalRequestDepartmentName;
      departmentList.add(department);

      BudgetType budgetType = BudgetType();
      budgetType.departmentId = approvalRequestDepartmentId;
      budgetType.departmentName = approvalRequestDepartmentName;
      budgetType.budgetTypeId = budgetTypeId;
      budgetType.budgetTypeName = budgetTypeName;
      budgetTypeList.add(budgetType);

      Bank bank = Bank();
      bank.bankName = bankName;
      bankList.add(bank);
    }

    getDepartmentList();
    getBudgetTypeList();
    getBankList();
  }

  void setWidgetData() {
    title.text = widget.receipt.title;
    requestAmount.text = widget.receipt.requestAmount.toString();
    memo.text = widget.receipt.memo;
    paymentDatetimeYear.text = widget.receipt.paymentDatetime.substring(0, 4);
    paymentDatetimeMonth.text = widget.receipt.paymentDatetime.substring(5, 7);
    paymentDatetimeDay.text = widget.receipt.paymentDatetime.substring(8, 10);
    paymentDatetimeHour.text = widget.receipt.paymentDatetime.substring(11, 13);
    paymentDatetimeMinute.text = widget.receipt.paymentDatetime.substring(14, 16);
    approvalRequestDepartmentId = widget.receipt.approvalRequestDepartmentId;
    approvalRequestDepartmentName = widget.receipt.approvalRequestDepartmentName;
    budgetTypeId = widget.receipt.budgetTypeId;
    budgetTypeName = widget.receipt.budgetTypeName;
    fileList = widget.receipt.fileList;
    bankName = widget.receipt.bankName;
    bankAccountNumber.text = widget.receipt.bankAccountNumber;
  }

  void getDepartmentList() async {
    String address = '/getDepartmentList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
      'groupId': AppCore.instance.getUser().selectGroup.groupId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      List<Department> tempList = <Department>[];
      tempList.add(Department());

      for (var json in jsonDecode(responseData.body))
      {
        Department department = Department();
        department.setData(json);
        tempList.add(department);
      }

      setState(() {
        departmentList = tempList;
        if (widget.receipt.requestId == -1 && departmentList.isNotEmpty) {
          widget.receipt.approvalRequestDepartmentId = departmentList[0].departmentId;
          widget.receipt.approvalRequestDepartmentName = departmentList[0].departmentName;
        }
      });
    }
  }

  void getBudgetTypeList() async {
    String address = '/getBudgetTypeList';
    Map<String, dynamic> body = {
      'userId': AppCore.instance.getUser().userId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      List<BudgetType> tempList = <BudgetType>[];

      for (var json in jsonDecode(responseData.body))
      {
        BudgetType budgetType = BudgetType();
        budgetType.setData(json);
        tempList.add(budgetType);
      }

      setState(() {
        budgetTypeList = tempList;
      });
    }
  }

  void getBankList() async {
    String address = '/getBankList';
    Map<String, dynamic> body = {
    };

    ResponseData responseData = await AppCore.request(ServerType.GET, address, body, null);

    if (responseData.statusCode == 200) {
      List<Bank> tempList = <Bank>[];
      tempList.add(Bank());

      for (var json in jsonDecode(responseData.body))
      {
        Bank bank = Bank();
        bank.setData(json);
        tempList.add(bank);
      }

      setState(() {
        bankList = tempList;
      });
    }
  }

  Future<void> addImage() async {
    List<XFile> tmpList = await ImagePicker().pickMultiImage();

    setState(() {
      fileList.addAll(tmpList);
    });
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

  void removeImage( XFile file) {
    setState(() {
      fileList.remove(file);
    });
  }

  Future<String> setData() async {
    if (title.text.isEmpty) {
      return '제목이 입력되지 않았습니다.';
    }
    else if (requestAmount.text.isEmpty) {
      return '금액이 입력되지 않았습니다.';
    }
    else if (paymentDatetimeYear.text.isEmpty) {
      return '결제연도가 입력되지 않았습니다.';
    }
    else if (paymentDatetimeMonth.text.isEmpty) {
      return '결제월이 입력되지 않았습니다.';
    }
    else if (paymentDatetimeDay.text.isEmpty) {
      return '결제일이 입력되지 않았습니다.';
    }
    else if (paymentDatetimeHour.text.isEmpty) {
      return '결제시간이 입력되지 않았습니다.';
    }
    else if (paymentDatetimeMinute.text.isEmpty) {
      return '결제분이 입력되지 않았습니다.';
    }
    else if (approvalRequestDepartmentId == -1) {
      return '부서가 선택되지 않았습니다.';
    }
    else if (budgetTypeId == -1) {
      return '결제 구분이 선택되지 않았습니다.';
    }
    else if (bankName.isEmpty) {
      return '은행이 선택되지 않았습니다';
    }
    else if (bankAccountNumber.text.isEmpty) {
      return '계좌번호가 입력되지 않았습니다.';
    }
    
    widget.receipt.title = title.text;
    widget.receipt.requestAmount = AppCore.parseInt(requestAmount.text);
    widget.receipt.memo = memo.text;
    widget.receipt.paymentDatetime = '${paymentDatetimeYear.text.padLeft(4, '0')}-${paymentDatetimeMonth.text.padLeft(2, '0')}-${paymentDatetimeDay.text.padLeft(2, '0')} ${paymentDatetimeHour.text.padLeft(2, '0')}:${paymentDatetimeMinute.text.padLeft(2, '0')}';
    widget.receipt.approvalRequestDepartmentId = approvalRequestDepartmentId;
    widget.receipt.approvalRequestDepartmentName = approvalRequestDepartmentName;
    widget.receipt.budgetTypeId = budgetTypeId;
    widget.receipt.budgetTypeName = budgetTypeName;
    widget.receipt.fileList = fileList;
    widget.receipt.bankName = bankName;
    widget.receipt.bankAccountNumber = bankAccountNumber.text;
    widget.receipt.submissionStatus = 1;

    return '';
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      appBarType: BarType.exit,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleText(
                text: '영수증을 제출해주세요',
              ),
              Text('제목',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldV1(
                keyboardType: TextInputType.text,
                controller: title,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                  FocusScope.of(context).nextFocus();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text('결제금액',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldV1(
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      controller: requestAmount,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      '원',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('메모',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldV1(
                keyboardType: TextInputType.name,
                controller: memo,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                  FocusScope.of(context).nextFocus();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text('결제일시',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: <Widget>[
                  Flexible(
                    flex: 4,
                    child: TextFormFieldV1(
                      textAlign: TextAlign.center,
                      counterText: '',
                      suffixIcon: Container(
                        width: 50,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Text(
                          '년',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      maxLength: 4,
                      keyboardType: TextInputType.number,
                      controller: paymentDatetimeYear,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {FocusScope.of(context).nextFocus();},
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 3,
                    child: TextFormFieldV1(
                      textAlign: TextAlign.center,
                      counterText: '',
                      suffixIcon: Container(
                        width: 50,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Text(
                          '월',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: paymentDatetimeMonth,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {FocusScope.of(context).nextFocus();},
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Flexible(
                    flex: 3,
                    child: TextFormFieldV1(
                      textAlign: TextAlign.center,
                      counterText: '',
                      suffixIcon: Container(
                        width: 50,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                        child: Text(
                          '일',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 25,
                          ),
                        ),
                      ),
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: paymentDatetimeDay,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {FocusScope.of(context).nextFocus();},
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormFieldV1(
                      textAlign: TextAlign.center,
                      counterText: '',
                      hintText: '00',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: paymentDatetimeHour,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  SizedBox(
                    width: 5,
                    child: Text(
                      ':',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: TextFormFieldV1(
                      textAlign: TextAlign.center,
                      counterText: '',
                      hintText: '00',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      maxLength: 2,
                      keyboardType: TextInputType.number,
                      controller: paymentDatetimeMinute,
                      textInputAction: TextInputAction.done,
                      onEditingComplete: () {
                        FocusScope.of(context).unfocus();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text('신청부서',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonV1(
                isExpanded: true,
                value: approvalRequestDepartmentName,
                items: departmentList.isNotEmpty ? departmentList.map(
                  (value) { 
                    return DropdownMenuItem<String>(
                      value: value.departmentName,
                      child: Text(value.departmentName),
                      );
                    },
                  ).toList() : [],
                onChanged: (value) {
                  setState(() {
                    approvalRequestDepartmentId = departmentList.firstWhere((department) => department.departmentName == value).departmentId;
                    approvalRequestDepartmentName = departmentList.firstWhere((department) => department.departmentName == value).departmentName;
                    if (budgetTypeList.firstWhereOrNull((element) => element.departmentName == value) != null) {
                      budgetTypeId = budgetTypeList.firstWhere((element) => element.departmentName == value).budgetTypeId;
                      budgetTypeName = budgetTypeList.firstWhere((element) => element.departmentName == value).budgetTypeName;
                    }
                    else {
                      budgetTypeId = -1;
                      budgetTypeName = '';
                    }
                  });
                }
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '구분',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonV1(
                isExpanded: true,
                value: budgetTypeName,
                items: approvalRequestDepartmentId != -1 && budgetTypeList.firstWhereOrNull((element) => element.departmentId == approvalRequestDepartmentId) != null ? budgetTypeList.map(
                  (value) {
                    return DropdownMenuItem<String>(
                      value: value.budgetTypeName,
                      child: Text(value.budgetTypeName),
                      );
                    },
                  ).toList() : [],
                onChanged: (value) {
                  setState(() {
                    budgetTypeId = budgetTypeList.firstWhere((element) => element.budgetTypeName == value).budgetTypeId;
                    budgetTypeName = budgetTypeList.firstWhere((element) => element.budgetTypeName == value).budgetTypeName;
                  });
                }
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '영수증 첨부',
                style: TextStyle(
                  fontSize: 20
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
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
                  itemCount: fileList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == fileList.length) {
                      return GestureDetector(
                        onTap: () {
                          addImage();
                        },
                        child: Container(
                          color: Colors.grey[200],
                          child: Icon(Icons.add),
                        ),
                      );
                    }
                    else {
                      final file = fileList.isNotEmpty ? fileList[index] : null;
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (file != null) {
                                showImage(context, File(file.path));
                              }
                            },
                            child: Image.file(
                              File(fileList[index].path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                if (file != null) {
                                  removeImage(file);
                                }
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ]
                      );
                    }
                  },
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('계좌번호',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        bankName = AppCore.instance.getUser().bankName;
                      });
                      bankAccountNumber.text = AppCore.instance.getUser().bankAccountNumber;
                    },
                    style: ButtonStyle(
                      overlayColor: MaterialStateProperty.resolveWith((states) => Color.fromARGB(80, 90, 68, 223)),
                    ),
                    child: Text('내 계좌')
                  ),
                ],
              ),
              DropdownButtonV1(
                isExpanded: true,
                value: bankName,
                items: bankList.map(
                  (value) {
                    return DropdownMenuItem<String>(
                      value: value.bankName,
                      child: Text(value.bankName),
                      );
                    },
                  ).toList(),
                onChanged: (value) {
                  setState(() {
                    bankName = bankList.firstWhere((element) => element.bankName == value).bankName;
                  });
                }
              ),
              SizedBox(
                height: 12,
              ),
              TextFormFieldV1(
                keyboardType: TextInputType.number,
                controller: bankAccountNumber,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12,
              ),
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(130),
                child: TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 90, 68, 223)),
                  ),
                  onPressed: () async {
                    String validationMessage = await setData();
                    if (validationMessage.isNotEmpty) {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '영수증 제출', validationMessage, ActionType.ok, () {
                        Navigator.pop(context);
                      });
                      return;
                    }

                    if (await widget.receipt.requestReceipt()) {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '영수증 제출', '제출 완료', ActionType.ok, () {
                        Navigator.pop(context);
                        Navigator.pop(context, true);
                      });
                    }
                    else {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '영수증 제출', '제출에 실패하였습니다.', ActionType.ok, () {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    '제출하기',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  )
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}