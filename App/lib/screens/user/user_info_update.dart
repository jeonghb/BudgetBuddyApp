import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import '../../models/user.dart';
import '../../widgets/text_form_field_v1.dart';
import '../../widgets/title_text.dart';
import '../screen_frame.dart';

class UserInfoUpdate extends StatefulWidget {
  const UserInfoUpdate({super.key});

  @override
  State<UserInfoUpdate> createState() => _UserInfoUpdate();
}

class _UserInfoUpdate extends State<UserInfoUpdate> {
  User user = AppCore.instance.getUser();
  List<String> bankList = [];
  TextEditingController bankAccountNumber = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPhoneNumber = TextEditingController();
  
  @override
  void initState() {
    super.initState();

    loadBankList();
  }

  Future<void> loadBankList() async {
    List<String> tempList = await AppCore.getBankList();

    setState(() {
      bankList = tempList;
    });
  }

  Future<bool> userUpdate() async {
    return await user.userUpdate();
  }

  void setData() {
    user.bankAccountNumber = bankAccountNumber.text;
    user.userEmail = userEmail.text;
    user.userPhoneNumber = userPhoneNumber.text;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: ListView(
          children: [
            TitleText(
              text: '개인정보 수정',
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
              controller: userEmail,
              textInputAction: TextInputAction.next,
              validator: (value) { return user.emailCheck();},
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
              controller: userPhoneNumber,
              textInputAction: TextInputAction.next,
              validator: (value) { return user.phoneNumberCheck();},
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
              value: user.bankName,
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
                  user.bankName = value.toString();
                });
              }
            ),
            SizedBox(
              height: 10,
            ),
            TextFormFieldV1(
              keyboardType: TextInputType.number,
              controller: bankAccountNumber,
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
                  setData();

                  if (await userUpdate()) { // 저장 성공 시
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '개인정보 수정', '저장되었습니다.', ActionType.ok, () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  }
                  else {
                    // ignore: use_build_context_synchronously
                    AppCore.showMessage(context, '개인정보 수정', '저장에 실패하였습니다.', ActionType.ok, () {
                      Navigator.pop(context);
                    });
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