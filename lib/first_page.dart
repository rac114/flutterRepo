import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('첫 번째 페이지'),
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
