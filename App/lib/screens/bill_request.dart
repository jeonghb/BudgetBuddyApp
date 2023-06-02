import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../models/bill.dart';
import '../models/department.dart';
import 'package:http/http.dart' as http;

class BillRequest extends StatefulWidget {
  const BillRequest({super.key});

  @override
  State<BillRequest> createState() => _BillRequest();
}

class _BillRequest extends State<BillRequest> {
  DateTime date = DateTime.now();
  List<Department> departmentList = <Department>[];
  Bill bill = Bill();

  @override
  void initState() {
    super.initState();

    GetDepartmentList(departmentList);
    bill.paymentDatetime.text = DateTime.now().toString();
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: bill.requestAmount,
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
                    controller: bill.memo,
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
                      value: bill.approvalRequestDepartmentName,
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
                          bill.approvalRequestDepartmentId = departmentList.firstWhere((element) => element.department_name == value).department_id;
                          bill.approvalRequestDepartmentName = departmentList.firstWhere((element) => element.department_name == value).department_name;
                        });
                      }
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      pickImageFromGallery(bill.fileList);
                    },
                    child: Text('사진 추가')
                  ),
                  TextButton(
                    onPressed: () async {
                      if (await bill.save()) {
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

Future<void> pickImageFromGallery(List<XFile> _fileList) async {
  final pickedImages = await ImagePicker().pickMultiImage();

  if (pickedImages != null) {
    _fileList.clear();
    _fileList.addAll(pickedImages);
  }
}