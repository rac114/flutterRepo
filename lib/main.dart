import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Launcher',
      theme: ThemeData(
        primarySwatch: Color.blue,
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
      backgroundColor: Colors.fromRGBO(243,239,230,1),
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
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.8,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final app = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    InstalledApps.startApp(app.packageName);
                  },
                  child: Column(
                    children: [
                      // 앱 아이콘 표시
                      if (app.icon != null)
                        Image.memory(app.icon!, width: 50, height: 50),
                      const SizedBox(height: 8),
                      // 앱 이름 표시
                      Text(
                        app.name!,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
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
