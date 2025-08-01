import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

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
  late Future<List<Application>> _apps;

  @override
  void initState() {
    super.initState();
    // 앱 목록을 비동기적으로 가져옵니다.
    _apps = DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: false, // 시스템 앱은 제외합니다.
      onlyAppsWithLaunchIntent: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Installed Apps'),
      ),
      body: FutureBuilder<List<Application>>(
        future: _apps,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No apps found.'));
          } else {
            // 앱 목록을 가져왔을 때 GridView로 표시합니다.
            return GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 한 줄에 4개의 앱을 표시합니다.
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                childAspectRatio: 0.8, // 아이콘과 텍스트의 비율을 조정합니다.
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final app = snapshot.data![index] as ApplicationWith  Icon;
                return GestureDetector(
                  onTap: () {
                    // 앱 아이콘을 탭하면 앱을 실행합니다.
                    DeviceApps.openApp(app.packageName);
                  },
                  child: Column(
                    children: [
                      // 앱 아이콘 표시
                      Image.memory(app.icon, width: 50, height: 50),
                      const SizedBox(height: 8),
                      // 앱 이름 표시
                      Text(
                        app.appName,
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
