import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/app_core.dart';
import 'package:test/widgets/title_text.dart';

import '../../models/news.dart';
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

  void initstate() {
    super.initState();

    getNewsData();
  }

  void getNewsData() async {
    String address = '/getNewsData';
    Map<String, dynamic> body = {
      'id': widget.id,
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200 && responseData.body.isNotEmpty) {
      List<News> tempList = <News>[];

      for (var json in jsonDecode(responseData.body)) {
        News news = News();
        news.setData(json);
        tempList.add(news);
      }

      setState(() {
        news = tempList[0];
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
            news.regUserId == AppCore.instance.getUser().userId.toString() ? // 작성자 본인일 경우
            Row(
              children: [
                Expanded(
                  child: TitleText(
                    text: news.title
                  )
                ),
                Expanded(
                  child: PopupMenuButton<String>(
                    onSelected: (String choice) async {
                      switch (choice) {
                        case '수정':
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsEdit(news: news))).then((value) {
                            getNewsData();
                          });
                        break;
                        case '삭제':
                          AppCore.showMessage(context, '소식 삭제', '소식을 삭제하시겠습니까?', ActionType.yesNo, () {
                            Navigator.pop(context);
                            if (!(news.newsDelete() as bool)) {
                              AppCore.showMessage(context, '소식 삭제', '삭제 실패', ActionType.ok, () {
                                Navigator.pop(context);
                              });
                            }
                            Navigator.pop(context);
                          });
                        break;
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return ['수정', '삭제'].map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(
                            choice,
                          )
                        );
                      }).toList();
                    },
                    // icon: Icon(Icons.more_vert),
                  )
                ),
              ],
            ) : AppCore.instance.getUser().isManager ? // 관리자일 경우
            Row(
              children: [
                Expanded(
                  child: TitleText(
                    text: news.title
                  )
                ),
                Expanded(
                  child: PopupMenuButton<String>(
                    onSelected: (String choice) {
                      AppCore.showMessage(context, '소식 삭제', '소식을 삭제하시겠습니까?', ActionType.yesNo, () {
                        Navigator.pop(context);
                        if (!(news.newsDelete() as bool)) {
                          AppCore.showMessage(context, '소식 삭제', '삭제 실패', ActionType.ok, () {
                            Navigator.pop(context);
                          });
                        }
                        Navigator.pop(context);
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return ['삭제'].map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(
                            choice,
                          )
                        );
                      }).toList();
                    },
                    // icon: Icon(Icons.more_vert),
                  )
                ),
              ],
            ) :
            TitleText(
              text: news.title
            ),
          ]
        )
      )
    );
  }
}