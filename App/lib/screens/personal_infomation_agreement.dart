import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_core.dart';
import '../models/response_data.dart';
import '../widgets/top_bar.dart';
import 'screen_frame.dart';

class PersonalInfomationAgreement extends StatefulWidget {
  PersonalInfomationAgreement({super.key});

  @override
  State<PersonalInfomationAgreement> createState() => _PersonalInfomationAgreement();
}

class _PersonalInfomationAgreement extends State<PersonalInfomationAgreement> {
  String documentText = '';

  @override
  void initState() {
    super.initState();

    getPersonalInfomationAgreementDocument();
  }

  Future<void> getPersonalInfomationAgreementDocument() async {
    String address = '/getPersonalInfomationAgreementDocument';
    Map<String, dynamic> body = {
    };

    ResponseData responseData = await AppCore.request(ServerType.GET, address, body, null);

    if (responseData.statusCode == 200 && responseData.bodyBytes.isNotEmpty) {
      setState(() {
        documentText = utf8.decode(base64.decode(jsonDecode(utf8.decode(responseData.bodyBytes))['bytes']));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      bottomBar: false,
      appBarType: BarType.exit,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Text(
                  documentText,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(120),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 90, 68, 223),
                  ),
                  child: Text(
                    '돌아가기',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        )
      )
    );
  }
}
