import 'package:flutter/material.dart';
import 'package:lib/first_page.dart';
import 'package:lib/second_page.dart';

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
