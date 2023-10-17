import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test/widgets/title_text.dart';

import '../../app_core.dart';
import '../../models/news.dart';
import '../../models/response_data.dart';
import '../screen_frame.dart';

class NewsList extends StatefulWidget {
  const NewsList({
    super.key,
  });

  @override
  State<NewsList> createState() => _NewsList();
}

class _NewsList extends State<NewsList> {
  List<News> newsList = <News>[];

  void initstate() {
    super.initState();

    getNewsList();
  }

  void getNewsList() async {
    String address = '/getNewsList';
    Map<String, dynamic> body = {
    };

    ResponseData responseData = await AppCore.request(ServerType.GET, address, body);

    if (responseData.statusCode == 200) {
      List<News> tempList = <News>[];
      
      for (var json in jsonDecode(responseData.body))
      {
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

          ]
        )
      )
    );
  }
}