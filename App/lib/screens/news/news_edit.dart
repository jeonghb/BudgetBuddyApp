import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test/widgets/title_text.dart';

import '../../app_core.dart';
import '../../models/department.dart';
import '../../models/news.dart';
import '../../widgets/text_form_field_v1.dart';
import '../screen_frame.dart';

class NewsEdit extends StatefulWidget {
  final News news;

  const NewsEdit({
    super.key,
    required this.news,
  });

  @override
  State<NewsEdit> createState() => _NewsEdit();
}

class _NewsEdit extends State<NewsEdit> {
  List<Department> departmentList = <Department>[];
  int selectDepartmentId = -1;
  String selectDepartmentName = '';
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (AppCore.instance.getUser().departmentList.isEmpty) {
      AppCore.showMessage(context, '소식 등록', '소속된 부서가 없습니다. 부서를 먼저 신청하세요.', ActionType.ok, () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
    }

    selectDepartmentId = widget.news.departmentId;
    selectDepartmentName = widget.news.departmentName;
    title.text = widget.news.title;
    content.text = widget.news.content;
    departmentList = AppCore.instance.getUser().departmentList;
  }

  Future<bool> newsDataEdit() {
    widget.news.departmentId = selectDepartmentId;
    widget.news.title = title.text;
    widget.news.content = content.text;

    return widget.news.newsEdit();
  }
  
  @override
  Widget build(BuildContext context) {
    return ScreenFrame(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleText(
                      text: '소식 수정',
                    ),
                    Text(
                      '부서',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    DropdownButton(
                      isExpanded: true,
                      value: selectDepartmentName,
                      items: departmentList.isNotEmpty ? departmentList.map(
                        (value) { 
                          return DropdownMenuItem<String>(
                            value: value.departmentName,
                            child: Text(value.departmentName),
                            );
                          },
                        ).toList() : [],
                      onChanged: (value) {
                        setState(() {
                          selectDepartmentId = departmentList.firstWhere((department) => department.departmentName == value).departmentId;
                          selectDepartmentName = departmentList.firstWhere((department) => department.departmentName == value).departmentName;
                        });
                      }
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '제목',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormFieldV1(
                      controller: title,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      onEditingComplete: () {
                        FocusScope.of(context).nextFocus();
                        FocusScope.of(context).nextFocus();
                        FocusScope.of(context).nextFocus();
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '내용',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormFieldV1(
                      controller: content,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      maxLength: 1000,
                      suffixIcon: Text(''),
                      maxLines: 10,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SizedBox(
                width: double.infinity,
                height: ScreenUtil().setHeight(130),
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 90, 68, 223),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )
                  ),
                  onPressed: () {
                    AppCore.showMessage(context, '소식 등록', '소식을 등록하시겠습니까?', ActionType.yesNo, () async {
                      Navigator.pop(context);
                      if (await newsDataEdit()) {
                        // ignore: use_build_context_synchronously  
                        Navigator.pop(context);
                      }
                      else {
                        // ignore: use_build_context_synchronously
                        AppCore.showMessage(context, '소식 등록', '저장 실패', ActionType.ok, () {
                          Navigator.pop(context);
                        });
                      }
                    });
                  },
                  child: Text(
                    '등록',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}