import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/Screen/HomeScree/view/List_Page.dart';
import 'package:todoapp/Screen/HomeScreen/View/HomePAge.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => HomePage(),
        'Home':(context) => ListPage(),
      },
    ),
  );
}
