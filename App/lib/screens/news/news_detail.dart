import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/app_core.dart';

import '../../models/news.dart';
import '../../models/report.dart';
import '../../models/response_data.dart';
import '../screen_frame.dart';
import 'news_edit.dart';

class NewsDetail extends StatefulWidget {
  final int id;

  const NewsDetail({
    super.key,
    required this.id,
  });

  @override
  State<NewsDetail> createState() => _NewsDetail();
}

class _NewsDetail extends State<NewsDetail> {
  News news = News();

  @override
  void initState() {
    super.initState();

    getNewsData();
  }

  void getNewsData() async {
    String address = '/getNewsData';
    Map<String, int> body = {
      'id': widget.id,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

    if (responseData.statusCode == 200) {
      var json = jsonDecode(responseData.body);

      setState(() {
        news.setData(json);
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
            Row(
              children: [
                Expanded(
                  flex: 12,
                  child: Text(
                    news.title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
                Expanded(
                  child: PopupMenuButton<String>(
                    onSelected: (String choice) async {
                      switch (choice) {
                        case '수정':
                          if (AppCore.instance.getUser().departmentList.isEmpty) {
                            AppCore.showMessage(context, '소식 수정', '소속된 부서가 없습니다. 부서를 먼저 신청하세요.', ActionType.ok, () {
                              Navigator.pop(context);
                            });
                          }
                          else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => NewsEdit(news: news))).then((value) {
                              getNewsData();
                            });
                          }
                        break;
                        case '삭제':
                          AppCore.showMessage(context, '소식 삭제', '소식을 삭제하시겠습니까?', ActionType.yesNo, () {
                            Navigator.pop(context);
                            if (!(news.newsDelete() as bool)) {
                              AppCore.showMessage(context, '소식 삭제', '삭제 실패', ActionType.ok, () {
                                Navigator.pop(context);
                              });
                            }
                            Navigator.pop(context, true);
                          });
                        break;
                        case '신고':
                          Report report = Report();
                          TextEditingController content = TextEditingController();
                          List<Widget>? widgets = <Widget>[
                            TextFormField(
                              controller: content,
                              maxLines: null,
                              decoration: InputDecoration(
                                hintText: '신고 내용을 입력하세요.',
                                contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                              ),
                            )
                          ];

                          AppCore.showMessage(context, '신고', '', ActionType.yesNo, () {
                            Navigator.pop(context);
                            report.type = Type.news;
                            report.typeId = news.id;
                            report.content = content.text;
                            report.reportAdd().then((bool result) {
                              if (result) {
                                AppCore.showMessage(context, '신고', '신고 완료', ActionType.ok, () {
                                  Navigator.pop(context, true);
                                });
                              }
                              else {
                                AppCore.showMessage(context, '신고', '신고 처리 중 오류가 발생하였습니다. 다시 시도해주세요.', ActionType.ok, () {
                                  Navigator.pop(context);
                                });
                              }
                            });
                          },
                          widgets: widgets);
                        break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      // 작성자 본인일 경우
                      if (news.regUserId == AppCore.instance.getUser().userId) {
                        return ['수정', '삭제'].map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                              choice,
                            )
                          );
                        }).toList();
                      }
                      // 관리자일 경우
                      else if (AppCore.instance.getUser().groupList.firstWhere((group) => group.groupId == AppCore.instance.getUser().selectGroupId).isManager) {
                        return ['삭제'].map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                              choice,
                            )
                          );
                        }).toList();
                      }
                      else {
                        return ['신고'].map((String choice) {
                          return PopupMenuItem<String>(
                            value: choice,
                            child: Text(
                              choice,
                            )
                          );
                        }).toList();
                      }
                    },
                  )
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  news.regUserName,
                ),
                Text(
                  news.regDatetime.substring(0, 16),
                ),
              ],
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              news.content,
            ),
          ]
        )
      )
    );
  }
}