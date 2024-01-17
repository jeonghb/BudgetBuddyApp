import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/screen_frame.dart';
import 'package:test/screens/user/update_password.dart';
import 'package:test/screens/user/user_info_update.dart';
import 'package:test/widgets/text_form_field_v1.dart';
import 'package:test/widgets/title_text.dart';

import '../../initialize.dart';

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

  @override
  void initState() {
    super.initState();

    if (widget.type == ScreenType.none) {
      AppCore.showMessage(context, '비밀번호 확인', '정상적이지 않습니다', ActionType.ok, () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }
  }

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
      if (widget.type == ScreenType.userWithdraw) {
        AppCore.showMessage(context, '계정 탈퇴', '정말로 계정 탈퇴하시겠습니까? 탈퇴 후 계정 복구가 불가능합니다', ActionType.yesNo, () async {
          Navigator.pop(context);
          
          if (await AppCore.instance.getUser().userWithdraw()) {
            // ignore: use_build_context_synchronously
            AppCore.showMessage(context, '계정 탈퇴', '탈퇴 완료', ActionType.ok, () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Initialize()), (route) => false);
            });
          }
          else {
            // ignore: use_build_context_synchronously
            AppCore.showMessage(context, '계정 탈퇴', '탈퇴 실패', ActionType.ok, () {
              Navigator.pop(context);
            });
          }
        });
      }
      else {
        nextScreenPush();
      }
    }
    else {
      AppCore.showMessage(context, '비밀번호 확인', '비밀번호가 일치하지 않습니다', ActionType.ok, () {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(
              text: '비밀번호 확인',
            ),
            Text(
              '현재 비밀번호 입력',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
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
                child: Text(
                  widget.type == ScreenType.userWithdraw ? '탈퇴' : '다음',
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
  userWithdraw,
}