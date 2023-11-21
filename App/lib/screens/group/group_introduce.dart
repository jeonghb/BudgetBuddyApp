import 'package:flutter/material.dart';
import 'package:test/screens/screen_frame.dart';

import '../../models/group.dart';

class GroupIntroduce extends StatefulWidget {
  final Group group;

  const GroupIntroduce({super.key, required this.group,});

  @override
  State<GroupIntroduce> createState() => _GroupIntroduce();
}

class _GroupIntroduce extends State<GroupIntroduce> {
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Column(
        children: [
        ]
      )
    );
  }
}