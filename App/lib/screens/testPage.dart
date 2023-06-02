import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
    width: 360,
    height: 90,
    child: Stack(
        children:[Positioned.fill(
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                    width: 360,
                    height: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20), bottomLeft: Radius.circular(0), bottomRight: Radius.circular(0), ),
                        boxShadow: [
                            BoxShadow(
                                color: Color(0x999893bb),
                                blurRadius: 10,
                                offset: Offset(0, 0),
                            ),
                        ],
                        color: Color(0xff5a44df),
                    ),
                    padding: const EdgeInsets.only(left: 38, right: 28, top: 12, bottom: 14, ),
                    child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:[
                            Container(
                                width: 40,
                                height: 44,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                        Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: FlutterLogo(size: 24),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                            "HOME",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xffc2b8f9),
                                                fontSize: 14,
                                                fontFamily: "Pretendard",
                                                fontWeight: FontWeight.w500,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            SizedBox(width: 73),
                            Container(
                                width: 48,
                                height: 44,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                        Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: FlutterLogo(size: 24),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                            "제출내역",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xffc2b8f9),
                                                fontSize: 14,
                                                fontFamily: "Pretendard",
                                                fontWeight: FontWeight.w500,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                            SizedBox(width: 73),
                            Container(
                                width: 60,
                                height: 44,
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children:[
                                        Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: FlutterLogo(size: 24),
                                        ),
                                        SizedBox(height: 3),
                                        Text(
                                            "청년부소식",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xffc2b8f9),
                                                fontSize: 14,
                                                fontFamily: "Pretendard",
                                                fontWeight: FontWeight.w500,
                                            ),
                                        ),
                                    ],
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        ),
        ],
    ),
);
  }
}