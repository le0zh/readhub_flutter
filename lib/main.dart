import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './common/model/NewsItem.dart';

void main() => runApp(MyApp());

// #246394

final items = List<String>.generate(100, (i) => 'ITEM $i');

Future<List<NewsItem>> fetchNewsItems() async {
  final response = await http.get('https://api.readhub.cn/technews?pageSize=30');

  if(response.statusCode == 200){
    return compute(parseNewsItem, response.body);
  }

  throw Exception('资讯加载失败');
}

List<NewsItem> parseNewsItem(String responseBody) {
  final parsed = json.decode(responseBody);

  return parsed['data'].map<NewsItem>((json) => NewsItem.fromJson(json)).toList();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'readhub',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'readhub'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<NewsItem>>(
        future: fetchNewsItems(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }

          return snapshot.hasData
              ? NewsList(posts: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class NewsList extends StatelessWidget {
  final List<NewsItem> posts;

  NewsList({Key key, this.posts}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(posts[index].title),
          subtitle: Row(
            children: <Widget>[
              Text(posts[index].siteName),
              Text(' / '),
              Text(posts[index].authorName),
            ],
          ),
        );
      },
    );
  }
}
