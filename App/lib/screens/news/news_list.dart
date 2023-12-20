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
      'departmentIdList': AppCore.instance.getUser().selectGroup.departmentList.map((e) => e.departmentId).toList(),
    };

    ResponseData responseData = await AppCore.request(ServerType.POST, address, body, null);

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
                                      Flexible(
                                        child: Text(
                                          news.title,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(20)),
                                          color: Color.fromARGB(236, 214, 215, 252),
                                        ),
                                        child: Text(
                                          news.departmentName,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.black,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            news.content,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 10,
                                            ),
                                          )
                                        ),
                                      ),
                                      Text(
                                        news.regDatetime.substring(0, 10),
                                      )
                                    ],
                                  )
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