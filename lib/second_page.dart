// second_page.dart
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Future<List<AppInfo>> _apps;

  @override
  void initState() {
    super.initState();
    // 앱 목록을 비동기적으로 가져옵니다.
    // excludeSystemApps: true 로 시스템 앱을 제외합니다.
    _apps = InstalledApps.getInstalledApps(true, true, "");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Installed Apps'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: Text('이전 페이지로 돌아가기'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          // FutureBuilder를 Expanded로 감싸서 남은 공간을 모두 차지하도록 함
          Expanded(
            child: FutureBuilder<List<AppInfo>>(
              future: _apps,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No apps found.'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final app = snapshot.data![index];
                      
                      // 체크박스 상태를 관리할 변수
                      bool isChecked = false; // 예시

                      return CheckboxListTile(
                        value: isChecked, // 체크박스의 현재 상태
                        onChanged: (bool? newValue) {
                          setState(() {
                            // isChecked 변수 업데이트
                          });
                        },
                        title: Text(app.name!),
                        subtitle: const Text('list subtitle'),
                        secondary: Image.memory(app.icon!, width: 50, height:50), // 앱 아이콘을 여기에 추가
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
