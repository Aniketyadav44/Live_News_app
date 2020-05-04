import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import './article_webview.dart';
import 'category_page.dart';
import 'contact.dart';
import 'package:flutter_icons/flutter_icons.dart';

List category = [
  {
    "name": "Business",
    "url":
        "https://images.unsplash.com/photo-1491336477066-31156b5e4f35?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
  },
  {
    "name": "Entertainment",
    "url":
        "https://images.unsplash.com/photo-1470229722913-7c0e2dbbafd3?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
  },
  {
    "name": "General",
    "url":
        "https://images.unsplash.com/photo-1472289065668-ce650ac443d2?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60"
  },
  {
    "name": "Health",
    "url":
        "https://images.unsplash.com/photo-1532938911079-1b06ac7ceec7?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
  },
  {
    "name": "Technology",
    "url":
        "https://images.unsplash.com/photo-1489389944381-3471b5b30f04?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60"
  }
];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map newsData;

  getTopNews() async {
    //put your api key in place of {your_api_key_here} in url below
    http.Response response = await http.get(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey={your_api_key_here}>");
    setState(() {
      this.newsData = jsonDecode(response.body);
    });
  }

  @override
  void initState() {
    getTopNews();
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
              IconButton(icon: Icon(FontAwesome.address_card), onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (context){
                return Contact();
              }));
            })
            ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 90,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryMenu(
                    imageUrl: category[index]["url"],
                    text: category[index]["name"],
                  );
                },
                itemCount: category.length,
              ),
            ),
            newsData == null
                ? SpinKitFadingCircle(
                    color: Colors.black,
                    size: 50,
                  )
                : Container(
                    margin: EdgeInsets.all(10),
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
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ArticleView(
                                        url: newsData["articles"][index]
                                            ["url"]);
                                  }));
                                },
                                child: Container(
                                  child: newsData["articles"][index]
                                              ["urlToImage"] ==
                                          null
                                      ? SpinKitFadingCircle(
                                          color: Colors.black, size: 50.0)
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                              Text(
                                newsData["articles"][index]["description"],
                                style: TextStyle(fontSize: 18),
                              ),
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

class CategoryMenu extends StatelessWidget {
  final String imageUrl;
  final String text;
  CategoryMenu({this.imageUrl, this.text});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryScreen(
            category: text.toLowerCase(),
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Stack(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl,
                height: 90,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black26),
              height: 90,
              width: 120,
              child: Text(
                text,
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontFamily:"BalooBhaina2"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
