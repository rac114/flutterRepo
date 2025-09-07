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
        scaffoldBackgroundColor: const Color.fromRGBO(243,239,230,1)
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

/*
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyDraggableContainer(),
    );
  }
}

class MyDraggableContainer extends StatefulWidget {
  @override
  _MyDraggableContainerState createState() => _MyDraggableContainerState();
}

class _MyDraggableContainerState extends State<MyDraggableContainer> {
  Color _containerColor = Colors.blue;
  String _message = '여기로 드래그하세요';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Draggable Container')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            // 드래그 가능한 컨테이너
            Draggable<Color>(
              data: Colors.red, // 드래그 시 전달할 데이터
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: Center(child: Text('드래그하세요')),
              ),
              feedback: Container(
                width: 100,
                height: 100,
                color: Colors.red.withOpacity(0.5),
                child: Center(child: Text('드래그 중')),
              ),
            ),
            
            // 드래그된 컨테이너가 놓일 곳
            DragTarget<Color>(
              onWillAccept: (data) => data == Colors.red,
              onAccept: (data) {
                setState(() {
                  _containerColor = data;
                  _message = '드래그 성공!';
                });
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 150,
                  height: 150,
                  color: _containerColor,
                  child: Center(child: Text(_message)),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
*/