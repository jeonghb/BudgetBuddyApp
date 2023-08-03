import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test/app_core.dart';
import 'package:test/widgets/menu_drawer.dart';

import '../models/response_data.dart';
import '../widgets/top_bar.dart';

class ReceiptCalculate extends StatefulWidget {
  final int departmentId;

  const ReceiptCalculate({super.key, required this.departmentId});

  @override
  State<ReceiptCalculate> createState() => _ReceiptCalculate();
}

class _ReceiptCalculate extends State<ReceiptCalculate> {
  List<String> monthList = <String>[];

  @override
  void initState() {
    super.initState();

    getMonthList();
  }

  Future<void> getMonthList() async {
    String address = '/getCalculateMonthList';
    Map<String, dynamic> body = {
        'userId': 'goddnsl',
        'departmentId': widget.departmentId,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(responseData.body);
      List<String> tempList = <String>[];
      
      for (Map<String, dynamic> json in jsonResponse) {
        tempList.add(json['month']);
      }

      setState(() {
        monthList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

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
                  Container(
                    width: 80,
                    height: 40,
                    child: DropdownButton(
                      value: monthList,
                      items: monthList.map(
                        (value) { 
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                            );
                          },
                        ).toList(),
                      onChanged: (value) {
                        setState(() {
                          
                        });
                      }
                    ),
                  ),
                ]
              )
            )
          )
        )
      )
    );
  }
}