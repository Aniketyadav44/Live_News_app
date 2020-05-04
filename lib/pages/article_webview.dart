import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class ArticleView extends StatefulWidget {
  final String url;
  ArticleView({this.url});
  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
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
            child: IconButton(padding: EdgeInsets.all(16),icon: Icon(Icons.backspace), onPressed: null))
        ],
      ),
          body: Container(
            height:MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
        child: WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            }),
      ),
    );
  }
}
