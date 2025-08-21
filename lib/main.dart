import 'package:flutter/material.dart';
import 'package:myapp/first_page.dart';
import 'package:myapp/second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(), // 앱의 시작 페이지
    );
  }
}
