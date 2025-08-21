// second_page.dart
import 'package:flutter/material.dart';
import 'package:myapp/first_page.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('두 번째 페이지'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('이전 페이지로 돌아가기'),
          onPressed: () {
            // Navigator를 사용하여 이전 페이지로 돌아감
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
