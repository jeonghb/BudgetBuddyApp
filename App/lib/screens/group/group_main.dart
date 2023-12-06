import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../app_core.dart';
import '../../widgets/top_bar.dart';
import '../screen_frame.dart';
import 'group_add.dart';
import 'group_list.dart';

class GroupMain extends StatefulWidget {
  const GroupMain({super.key});

  @override
  State<GroupMain> createState() => _GroupMain();
}

class _GroupMain extends State<GroupMain> {
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      isAlarm: false,
      appBarType: AppCore.instance.getUser().selectGroupId != -1 ? BarType.logout : BarType.invisible,
      isDrawer: false,
      // backgroundColor: Color.fromARGB(255, 90, 68, 223),
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppCore.instance.getUser().selectGroupId == -1 ? '아직 소속된 그룹이 없어요!' : '그룹관리',
              style: TextStyle(
                fontSize: 20,
              )
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(130),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GroupList()));
                },
                child: Text(
                  '그룹 가입',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: double.infinity,
              height: ScreenUtil().setHeight(130),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
                ),
                onPressed: () async {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => GroupAdd()));
                },
                child: Text(
                  '그룹 생성',
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
    );
  }
}