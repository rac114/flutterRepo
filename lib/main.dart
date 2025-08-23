import 'package:flutter/material.dart';
import 'package:myapp/second_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(), // 앱의 시작 페이지
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.lightGreen
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('첫 번째 페이지!!!'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('다음 페이지로 이동'),
          onPressed: () {
            // Navigator를 사용하여 SecondPage로 이동
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SecondPage()),
            );
          },
        ),
      ),
    );
  }
}
