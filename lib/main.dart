import 'package:flutter/material.dart';
import './pages/homepage.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget{
  Widget build(BuildContext context){
    return MaterialApp(
      title: "KHABAR",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      home:HomePage()
    );
  }
}