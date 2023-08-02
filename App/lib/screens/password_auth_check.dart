import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/screen_frame.dart';
import 'package:test/screens/update_password.dart';
import 'package:test/screens/user_info_update.dart';
import 'package:test/widgets/text_form_field_v1.dart';

class PasswordAuthCheck extends StatefulWidget {
  final ScreenType type;
  const PasswordAuthCheck({
      super.key,
      this.type = ScreenType.none,
    }
  );

  @override
  State<PasswordAuthCheck> createState() => _PasswordAuthCheck();
}

class _PasswordAuthCheck extends State<PasswordAuthCheck> {
  TextEditingController password = TextEditingController();

  void nextScreenPush() {
    Navigator.pop(context);

    switch (widget.type) {
      case ScreenType.userInfoUpdate:
        Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfoUpdate()));
      break;
      case ScreenType.passwordUpdate:
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword(user: AppCore.instance.getUser())));
      break;
      default:
      break;
    }
  }

  void auth() {
    if (AppCore.instance.getUser().passwordAuthCheck(password.text)) {
      nextScreenPush();
    }
    else {
      showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(children: const <Widget>[Text('비밀번호 확인')]),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[Text('비밀번호가 일치하지 않습니다.',),],
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
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text('비밀번호 확인'),
            SizedBox(
              height: 20,
            ),
            TextFormFieldV1(
              obscureText: true,
              controller: password,
              onEditingComplete: () {
                FocusScope.of(context).unfocus();
                auth();
              },
            ),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () {
                auth();
              },
              child: Text(
                '확인',
              )
            ),
          ],
        ),
      ),
    );
  }
}

enum ScreenType {
  none,
  userInfoUpdate,
  passwordUpdate,
}