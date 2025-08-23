// second_page.dart
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Launcher',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AppListScreen(),
    );
  }
}

class AppListScreen extends StatefulWidget {
  const AppListScreen({Key? key}) : super(key: key);

  @override
  _AppListScreenState createState() => _AppListScreenState();
}

class _AppListScreenState extends State<AppListScreen> {
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
      body: FutureBuilder<List<AppInfo>>(
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
                return GestureDetector(
                  onTap: () {
                    InstalledApps.startApp(app.packageName);
                  },
                  child: ListTile(
														  	leading: if (app.icon != null) {Image.memory(app.icon!, width: 50, height:50),
																title: Text(app.name!),
																subtitle: const Text('list subtitle'),	
														),
                );
              },
            );
          }
        },
      ),
    );
  }
}
