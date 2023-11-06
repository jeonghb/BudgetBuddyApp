import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/screen_frame.dart';
import 'package:test/screens/user/update_password.dart';
import 'package:test/screens/user/user_info_update.dart';
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
        Navigator.push(context, MaterialPageRoute(builder: (context) => UpdatePassword()));
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
      AppCore.showMessage(context, '비밀번호 확인', '비밀번호가 일치하지 않습니다.', ActionType.ok, () {
        Navigator.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Text(
              '본인확인을 위해 \n비밀번호를 입력해주세요.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
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
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(120),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                ),
                child: Text('다음',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white
                ),),
                onPressed: () async {
                  auth();
                },
              ),
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