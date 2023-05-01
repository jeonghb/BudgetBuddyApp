import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'class/BillData.dart';

class Bill extends StatefulWidget {
  const Bill({super.key});

  @override
  State<Bill> createState() => _Bill();
}

BillData billData = BillData();

class _Bill extends State<Bill> {
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
                      fontWeight: FontWeight.bold,
                      fontSize: 40
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
                    controller: billData.requestAmount,
                    textInputAction: TextInputAction.next,
                  ),
                  Text('멤버',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40
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
                    controller: billData.memberList,
                    textInputAction: TextInputAction.next,
                  ),
                ],
              )
            )
          )
        )
      )
    );
  }
}