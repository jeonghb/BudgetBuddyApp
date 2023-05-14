import 'package:flutter/material.dart';

import 'BillApproval.dart';
import 'BillRequest.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> {
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BillRequest()),);
                    },
                    child: Text('영수증 제출')
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => BillApproval()),);
                    },
                    child: Text('영수증 결재')
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