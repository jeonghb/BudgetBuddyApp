import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/screen_frame.dart';
import 'package:test/widgets/text_form_field_v1.dart';
import '../models/receipt.dart';
import '../models/department.dart';
import 'package:http/http.dart' as http;

class ReceiptRequest extends StatefulWidget {
  final Receipt receipt;

  const ReceiptRequest({super.key, required this.receipt});

  @override
  State<ReceiptRequest> createState() => _ReceiptRequest();
}

class _ReceiptRequest extends State<ReceiptRequest> {
  DateTime date = DateTime.now();
  List<Department> departmentList = <Department>[];

  @override
  void initState() {
    super.initState();

    getDepartmentList(departmentList);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      isAppBar: true,
      isDrawer: true,
      isAlarm: false,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(30),
          child: ListView(
            scrollDirection: Axis.vertical,
            children: <Widget>[
              Text(
                '영수증을 제출해주세요',
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 30,
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
                controller: widget.receipt.title,
                textInputAction: TextInputAction.next,
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
                      controller: widget.receipt.requestAmount,
                      textInputAction: TextInputAction.next,
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
                controller: widget.receipt.memo,
                textInputAction: TextInputAction.next,
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
                      controller: widget.receipt.paymentDatetimeYear,
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
                      controller: widget.receipt.paymentDatetimeMonth,
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
                      controller: widget.receipt.paymentDatetimeDay,
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
                      controller: widget.receipt.paymentDatetimeHour,
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
                      controller: widget.receipt.paymentDatetimeMinute,
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
              DropdownButton(
                isExpanded: true,
                value: widget.receipt.approvalRequestDepartmentName,
                items: departmentList.map(
                  (value) { 
                    return DropdownMenuItem<String>(
                      value: value.department_name,
                      child: Text(value.department_name),
                      );
                    },
                  ).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.receipt.approvalRequestDepartmentId = departmentList.firstWhere((element) => element.department_name == value).department_id;
                    widget.receipt.approvalRequestDepartmentName = departmentList.firstWhere((element) => element.department_name == value).department_name;
                  });
                }
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
                  itemCount: widget.receipt.fileList.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    final file =  widget.receipt.fileList.isNotEmpty ? widget.receipt.fileList[index] : null;

                    if (index == widget.receipt.fileList.length) {
                      return GestureDetector(
                        onTap: () {
                          addImage(widget.receipt);
                        },
                        child: Container(
                          color: Colors.grey,
                          child: Icon(Icons.add),
                        ),
                      );
                    }
                    else {
                      return Stack(
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (file != null) {
                                showImage(context, File(file.path));
                              }
                            },
                            child: Image.file(
                              File(widget.receipt.fileList[index].path),
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () {
                                if (file != null) {
                                  removeImage(widget.receipt, file);
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
                      widget.receipt.AccountNumber.text = '1002-340-513599';
                    },
                    child: Text('내 계좌')
                  ),
                ],
              ),
              TextFormFieldV1(
                keyboardType: TextInputType.number,
                controller: widget.receipt.AccountNumber,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(
                height: 12,
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 90, 68, 223)),
                ),
                onPressed: () async {
                  if (await widget.receipt.save()) {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          title: Column(children: const <Widget>[Text('영수증 제출')]),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[Text("제출 완료",),],
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
                },
                child: Text(
                  '제출하기',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ),
            ],
          )
        )
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: ScreenUtil().setHeight(360),
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}

void getDepartmentList(List<Department> departmentList) async {
  Uri uri = Uri.parse('${AppCore.baseUrl}/getDepartmentList');

  http.Response response = await http.get(
    uri,
    headers: {"Content-Type": "application/json"},
  );

  departmentList.add(Department());

  for (var json in jsonDecode(response.body))
  {
    Department department = Department();
    department.setData(json);
    departmentList.add(department);
  }
}

Future<void> addImage(Receipt receipt) async {
  List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();

  receipt.fileList = pickedFiles;
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

void removeImage(Receipt _receipt, XFile _file) {
  _receipt.fileList.remove(_file);
}