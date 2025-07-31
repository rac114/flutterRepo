import 'package:flutter/material.dart';
import 'package:device_apps_plus/device_apps_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LauncherScreen(),
    );
  }
}

class LauncherScreen extends StatefulWidget {
  @override
  _LauncherScreenState createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  List<Application> apps = [];

  @override
  void initState() {
    super.initState();
    loadApps();
  }

  void loadApps() async {
    List<Application> installedApps = await DeviceApps.getInstalledApplications(
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true, // 실행 가능한 앱만
      includeAppIcons: true, // 아이콘 포함
    );
    setState(() {
      apps = installedApps;
    });
  }

  void launchApp(String packageName) {
    DeviceApps.openApp(packageName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("내 런처")),
      body: apps.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
              ),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index] as ApplicationWithIcon;
                return GestureDetector(
                  onTap: () => launchApp(app.packageName),
                  child: Column(
                    children: [
                      Image.memory(app.icon, width: 50, height: 50),
                      Text(
                        app.appName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
