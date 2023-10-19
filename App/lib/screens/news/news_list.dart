import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/widgets/title_text.dart';

import '../../app_core.dart';
import '../../models/news.dart';
import '../../models/response_data.dart';
import '../screen_frame.dart';
import 'news_detail.dart';

class NewsList extends StatefulWidget {
  const NewsList({
    super.key,
  });

  @override
  State<NewsList> createState() => _NewsList();
}

class _NewsList extends State<NewsList> {
  List<News> newsList = <News>[];

  @override
  void initState() {
    super.initState();

    getNewsList();
  }

  void getNewsList() async {
    String address = '/getNewsList';
    Map<String, dynamic> body = {
      'departmentIdList': AppCore.instance.getUser().departmentList.map((e) => e.departmentId).toList(),
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body);

    if (responseData.statusCode == 200) {
      List<News> tempList = <News>[];
      
      for (var json in jsonDecode(responseData.body)) {
        News news = News();
        news.setData(json);

        tempList.add(news);
      }

      setState(() {
        newsList = tempList;
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
              text: '소식',
            ),
            Expanded(
              flex: 7,
              child: ListView.builder(
                physics: ScrollPhysics(),
                shrinkWrap: true,
                itemCount: newsList.length,
                itemBuilder: (BuildContext context, int index) {
                  News news = newsList[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewsDetail(id: news.id)),).then((value) {
                        getNewsList();
                      });
                    },
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Color.fromARGB(31, 0, 0, 0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        news.title,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        news.regDatetime.substring(0, 10),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      news.content.contains('\n') ?
                                      '${news.content.split('\n').first}...' :
                                      news.content,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    )
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        )
                      ]
                    )
                  );
                }
              )
            ),
          ]
        )
      )
    );
  }
}