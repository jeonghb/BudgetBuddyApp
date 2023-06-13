import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

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

    GetDepartmentList(departmentList);
    widget.receipt.paymentDatetime.text = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
    final receipt = widget.receipt;

    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('SANDOL',
            style: TextStyle(
              color: Color.fromARGB(255, 90, 68, 223),
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('제목',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.text,
                    controller: receipt.title,
                    textInputAction: TextInputAction.next,
                  ),
                  Text('결제금액',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    controller: receipt.requestAmount,
                    textInputAction: TextInputAction.next,
                  ),
                  Text('메모',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.name,
                    controller: receipt.memo,
                    textInputAction: TextInputAction.next,
                  ),
                  Text('결제일시',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  CupertinoButton(
                    child: Text('${date.year}-${date.month}-${date.day}',
                      style: TextStyle(
                        color: Colors.blue
                      ),
                    ),
                    onPressed: () {
                      _showDialog(
                        CupertinoDatePicker(
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() => date = newDate); 
                          },
                          mode: CupertinoDatePickerMode.date,
                          initialDateTime: date,
                          maximumDate: DateTime.now(),
                        ),
                      );
                    }
                  ),
                  CupertinoButton(
                    child: Text('${date.hour}:${date.minute}',
                      style: TextStyle(
                        color: Colors.blue
                      ),
                    ), 
                    onPressed: () {
                      _showDialog(
                        CupertinoDatePicker(
                          onDateTimeChanged: (DateTime newDate) {
                            setState(() => date = newDate);
                        },
                          mode: CupertinoDatePickerMode.time,
                          initialDateTime: date,
                        ),
                      );
                    },
                  ),
                  Text('신청부서',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 40,
                    child: DropdownButton(
                      value: receipt.approvalRequestDepartmentName,
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
                          receipt.approvalRequestDepartmentId = departmentList.firstWhere((element) => element.department_name == value).department_id;
                          receipt.approvalRequestDepartmentName = departmentList.firstWhere((element) => element.department_name == value).department_name;
                        });
                      }
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: 300,
                    height: 100,
                    child: GridView.builder(
                      padding: EdgeInsets.all(8),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                      ),
                      itemCount: receipt.fileList.length + 1,
                      itemBuilder: (BuildContext context, int index) {
                        final file =  receipt.fileList.length > 0 ? receipt.fileList[index] : null;

                        if (index == receipt.fileList.length) {
                          return GestureDetector(
                            onTap: () {
                              addImage(receipt);
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
                                  if (file != null)
                                    showImage(context, File(file.path));
                                },
                                child: Image.file(
                                  File(receipt.fileList[index].path),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    if (file != null)
                                      removeImage(receipt, file);
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
                    children: <Widget>[
                      Text('계좌번호',
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          receipt.AccountNumber.text = '1002-340-513599';
                        },
                        child: Text('내 계좌')
                      ),
                    ],
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Color.fromARGB(255, 90, 68, 223))
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        borderSide: BorderSide(color: Colors.red)
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: true,
                    autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    controller: receipt.AccountNumber,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (await receipt.save()) {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context, 
                          builder: (BuildContext context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              title: Column(children: <Widget>[Text('영수증 제출')]),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[Text("제출 완료",),],
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
                    child: Text('제출')
                  ),
                ],
              )
            )
          )
        )
      )
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

void GetDepartmentList(List<Department> _departmentList) async {
    Uri uri = Uri.parse('http://211.197.27.23:8081/getDepartmentList');

    http.Response response = await http.get(
      uri,
      headers: {"Content-Type": "application/json"},
    );

    _departmentList.add(Department());

    for (var json in jsonDecode(response.body))
    {
      Department department = Department();
      department.setData(json);
      _departmentList.add(department);
    }
}

Future<void> addImage(Receipt _receipt) async {
  List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();

  if (pickedFiles != null) {
    _receipt.fileList = pickedFiles;
  }
}

void showImage(BuildContext _context, File _file) {
  showDialog(
    context: _context, 
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Image.file(_file),
        ),
      );
    }
  );
}

void removeImage(Receipt _receipt, XFile _file) {
  if (_file != null) {
    _receipt.fileList.remove(_file);
  }
}