import 'package:flutter/material.dart';

import 'class/BillData.dart';

class BillApproval extends StatefulWidget {
  const BillApproval({super.key});

  @override
  State<BillApproval> createState() => _BillApproval();
}

BillData billData = BillData();

class _BillApproval extends State<BillApproval> {
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
                  Text('결제금액',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(billData.requestAmount.text.toString(),
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text('참여자',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(billData.memberList.text.toString(),
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text('메모',
                    style: TextStyle(
                      fontSize: 20
                    ),
                  ),
                  Text(billData.memo.text.toString(),
                    style: TextStyle(
                      fontSize: 20
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