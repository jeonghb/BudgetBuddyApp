import 'package:flutter/material.dart';

import '../models/bill.dart';

class BillApprovalList extends StatefulWidget {
  const BillApprovalList({super.key});

  @override
  State<BillApprovalList> createState() => _BillApprovalList();
}

List<Bill> billList = <Bill>[];

class _BillApprovalList extends State<BillApprovalList> {

  @override
  void initState() {
    super.initState();

    GetBillApprovalList();
  }

  @override
  Widget build(BuildContext context){
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
                ]
              )
            )
          )
        )
      )
    );
  }
}

void GetBillApprovalList() {
  
}