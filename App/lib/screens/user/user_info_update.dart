import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import '../../widgets/text_form_field_v1.dart';
import '../screen_frame.dart';

class UserInfoUpdate extends StatefulWidget {
  const UserInfoUpdate({super.key});

  @override
  State<UserInfoUpdate> createState() => _UserInfoUpdate();
}

class _UserInfoUpdate extends State<UserInfoUpdate> {
  List<String> bankList = [];

  @override
  void initState() {
    super.initState();
    loadBankList();
  }

  Future<void> loadBankList() async {
    bankList = await AppCore.getBankList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: [
            Text(
              '개인정보 수정',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text('이메일',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormFieldV1(
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.emailAddress,
              controller: AppCore.instance.getUser().userEmail,
              textInputAction: TextInputAction.next,
              validator: (value) { return AppCore.instance.getUser().emailCheck();},
              onEditingComplete: () {
                FocusScope.of(context).nextFocus();
                FocusScope.of(context).nextFocus();
              },
            ),
            SizedBox(
              height: 10,
            ),
            Text('휴대폰번호',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormFieldV1(
              autovalidateMode: AutovalidateMode.always,
              keyboardType: TextInputType.phone,
              controller: AppCore.instance.getUser().userPhoneNumber,
              textInputAction: TextInputAction.next,
              validator: (value) { return AppCore.instance.getUser().phoneNumberCheck();},
            ),
            SizedBox(
              height: 10,
            ),
            Text('계좌번호',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(
              height: 5,
            ),
            DropdownButton(
              isExpanded: true,
              value: AppCore.instance.getUser().bankName,
              items: bankList.map(
                (value) { 
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      ),
                    );
                  },
                ).toList(),
              onChanged: (value) {
                setState(() {
                  AppCore.instance.getUser().bankName = value.toString();
                });
              }
            ),
            SizedBox(
              height: 10,
            ),
            TextFormFieldV1(
              keyboardType: TextInputType.number,
              controller: AppCore.instance.getUser().bankAccountNumber,
              textInputAction: TextInputAction.done,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 60,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 90, 68, 223)),
                ),
                onPressed: () async {
                  if (await AppCore.instance.getUser().userUpdate() == 'true') { // 저장 성공 시
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          title: Column(children: const <Widget>[Text('개인정보 수정')]),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[Text("저장되었습니다.",),],
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
                  else {
                    // ignore: use_build_context_synchronously
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          title: Column(children: const <Widget>[Text('개인정보 수정')]),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const <Widget>[Text("저장에 실패하였습니다.",),],
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text('확인'), 
                              onPressed: () {
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
                  '저장',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              ),
            ),
          ],
        )
      )
    );
  }
}