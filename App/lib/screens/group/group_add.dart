import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/app_core.dart';
import 'package:test/screens/screen_frame.dart';
import 'package:test/widgets/text_form_field_v1.dart';
import 'package:test/widgets/title_text.dart';
import 'package:test/widgets/top_bar.dart';

import '../../models/group.dart';

class GroupAdd extends StatefulWidget {
  const GroupAdd({super.key});

  @override
  State<GroupAdd> createState() => _GroupAdd();
}

class _GroupAdd extends State<GroupAdd> {
  Group group = Group();
  TextEditingController groupName = TextEditingController();
  TextEditingController groupIntroduceMemo = TextEditingController();

  void setData() {
    group.groupName = groupName.text;
    group.groupIntroduceMemo = groupIntroduceMemo.text;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      appBarType: AppCore.instance.getUser().selectGroup.groupId != -1 ? BarType.exit : BarType.invisible,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText(
                text: '그룹 생성',
              ),
              Text(
                '그룹명',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldV1(
                controller: groupName,
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).nextFocus();
                  FocusScope.of(context).nextFocus();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                '그룹 소개글',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormFieldV1(
                controller: groupIntroduceMemo,
                keyboardType: TextInputType.multiline,
                maxLength: 1000,
                suffixIcon: Text(''),
                textInputAction: TextInputAction.newline,
                maxLines: 10,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(130),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 90, 68, 223),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  onPressed: () async {
                    setData();

                    if (await group.groupAdd()) {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '그룹 생성', '그룹 생성이 완료되었습니다. 관리자가 승인 확인을 기다려주세요.', ActionType.ok, () {
                        Navigator.pop(context);
                      });

                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      
                      // ignore: use_build_context_synchronously
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Home(groupId: AppCore.instance.getUser().groupList[0].groupId)), (route) => false,);
                    }
                    else {
                      // ignore: use_build_context_synchronously
                      AppCore.showMessage(context, '그룹 생성', '그룹 생성 실패', ActionType.ok, () {
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    '생성',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}