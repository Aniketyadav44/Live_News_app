import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './article_webview.dart';
import 'package:flutter_icons/flutter_icons.dart';

class CategoryScreen extends StatefulWidget {
  final String category;
  CategoryScreen({this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}


class _CategoryScreenState extends State<CategoryScreen> {
  Map newsData;
  
  getNewsData()async{
    //put your api key in place of {your_api_key_here} in url below
    final String url="https://newsapi.org/v2/top-headlines?country=in&category=${widget.category}&apiKey={your_api_key_here}";
    http.Response response=await http.get(url);
    setState(() {
      this.newsData=json.decode(response.body);
    });
  }

  @override
  void initState() {
    getNewsData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "AAJ",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "KI",
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
            Text(
              "NEWS",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity:0,
            child: IconButton(padding: EdgeInsets.all(16),icon: Icon(FontAwesome.address_card), onPressed: null)),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            newsData == null
                ? SpinKitFadingCircle(
                    color: Colors.black,
                    size: 50,
                  )
                : Container(
                  margin:EdgeInsets.all(10),
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsData["articles"].length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(),
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: <Widget>[
                              GestureDetector(
                                onTap: ()  {
                                Navigator.push(context,MaterialPageRoute(builder: (context){
                                  return ArticleView(url:newsData["articles"][index]["url"]);
                                }));
                                },
                                child: Container(
                                  child: newsData["articles"][index]
                                              ["urlToImage"] ==
                                          null
                                      ? SpinKitFadingCircle(
                                          color: Colors.black, size: 50.0)
                                      : ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                                                              child: Image.network(
                                            newsData["articles"][index]
                                                ["urlToImage"],
                                            height: 250,
                                            width: double.infinity,
                                            fit: BoxFit.cover,
                                          ),
                                      ),
                                ),
                              ),
                              Text(newsData["articles"][index]["title"],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 23)),
                              Text(newsData["articles"][index]["description"],
                                  style: TextStyle(fontSize: 18),),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}