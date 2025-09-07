// original code
/*
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
*/

// drag example
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

// pref counter example
/*
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _counter = 0;
  final String _counterKey = 'counter_value';

  @override
  void initState() {
    super.initState();
    _loadCounter(); // 앱 시작 시 저장된 값 불러오기
  }

  // SharedPreferences에서 정수 값을 불러오는 함수
  _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      // 'counter_value' 키로 저장된 정수 값을 불러옵니다.
      // 값이 없으면 기본값인 0을 사용합니다.
      _counter = prefs.getInt(_counterKey) ?? 0;
    });
  }

  // SharedPreferences에 정수 값을 저장하는 함수
  _incrementCounter() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _counter++; // 카운터 값 증가
    });
    // 'counter_value' 키에 현재 _counter 값을 저장합니다.
    await prefs.setInt(_counterKey, _counter);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SharedPreferences 예제'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                '저장된 정수 값:',
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _incrementCounter,
                child: const Text('값 증가 및 저장'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

// changable button example
/*
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('텍스트 수정 예제'),
        ),
        body: Center(
          child: EditableContainer(),
        ),
      ),
    );
  }
}

class EditableContainer extends StatefulWidget {
  @override
  _EditableContainerState createState() => _EditableContainerState();
}

class _EditableContainerState extends State<EditableContainer> {
  // 화면에 표시될 텍스트 상태 변수
  String _displayText = '길게 눌러 텍스트 수정하기';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        _showEditDialog(context);
      },
      child: Container(
        width: 300,
        height: 100,
        color: Colors.blue,
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Text(
          _displayText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    // 텍스트 필드의 컨트롤러
    final TextEditingController _textController =
        TextEditingController(text: _displayText);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('텍스트 수정'),
          content: TextField(
            controller: _textController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "새로운 텍스트를 입력하세요",
            ),
          ),
          actions: [
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                // 새로운 텍스트로 상태 업데이트
                setState(() {
                  _displayText = _textController.text;
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
*/

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: EditableButton(),
        ),
      ),
    );
  }
}

class EditableButton extends StatefulWidget{
  @override
  _EditableButtonState createState() => _EditableButtonState();
}

class _EditableButtonState extends State<EditableButton> {
  String _displayText = "initial Text";
  final String _buttonKey = "button key";

  @override
  void initState(){
    super.initState();
    _loadButton();
  }

  _loadButton() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _displayText = prefs.getString(_buttonKey) ?? "null loaded";
    });
  }
  
  _setButton(String newText) async {
    final prefs = await SharedPreferences.getInstance();
    setState((){_displayText = newText});
    await prefs.setString(_buttonKey, newText);
  }

  void _showEditDialog(BuildContext context) {
    // 텍스트 필드의 컨트롤러
    final TextEditingController _textController =
      TextEditingController(text: _displayText);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('텍스트 수정'),
          content: TextField(
            controller: _textController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "새로운 텍스트를 입력하세요",
            ),
          ),
          actions: [
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('확인'),
              onPressed: () {
                // 새로운 텍스트로 상태 업데이트
                setState(() {
                  _setButton(_textController.text);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: (){
        _showEditDialog(context);
      },
      child: Container(
        width: 300,
        height: 100,
        color: Colors.blue,
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: Text(
          _displayText,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
