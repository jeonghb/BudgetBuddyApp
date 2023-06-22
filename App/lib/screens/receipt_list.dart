import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/receipt_detail.dart';

import '../models/receipt.dart';
import '../widgets/menu_drawer.dart';
import '../widgets/top_bar.dart';

class ReceiptList extends StatefulWidget {
  final int submissionStatus;
  
  const ReceiptList({super.key, required this.submissionStatus});

  @override
  State<ReceiptList> createState() => _ReceiptList();
}

List<Receipt> receiptList = <Receipt>[];

class _ReceiptList extends State<ReceiptList> {
  get submissionStatus => widget.submissionStatus;

  @override
  void initState() {
    super.initState();

    GetReceiptList();
  }
  
  Future<void> GetReceiptList() async {
    Uri uri = Uri.parse('${AppCore.baseUrl}/getReceiptList');

    http.Response response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        'userId': 'goddnsl',
        'submissionStatus': submissionStatus,
        })
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Receipt> tempList = [];
      
      for (Map<String, dynamic> json in jsonResponse) {
        Receipt receipt = Receipt();
        receipt.fromJson(json);
        tempList.add(receipt);
      }

      setState(() {
        receiptList = tempList;
      });
    }
  }

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: () => { FocusScope.of(context).unfocus()},
      child: Scaffold(
        appBar: TopBar(type: BarType.login),
        endDrawer: MenuDrawer(),
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: receiptList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final receipt = receiptList[index];
                      final hasIamge = receipt.fileList.isNotEmpty;

                      return GestureDetector(
                        onTap: () {
                          AuthLevel authLevel = AuthLevel.view;
                          
                          if (submissionStatus == -1) {
                            authLevel = AuthLevel.view;
                          }
                          else if (submissionStatus == 1) {
                            authLevel = AuthLevel.approval;
                          }

                          Navigator.push(context, MaterialPageRoute(builder: (context) => ReceiptDetail(receipt: receipt, authLevel: authLevel,)),);
                        },
                        child: Column (
                          children: [
                            ListTile(
                            leading: Text(receipt.title.text),
                            trailing: hasIamge ? Image.file(File(receipt.fileList[0].path)) : null,
                            ),
                            Divider(),
                          ]
                        ),
                      );
                    }
                  )
                ),
              ]
            )
          )
        )
      )
    );
  }
}