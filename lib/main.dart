import 'package:flutter/material.dart';
// device_apps_plus의 API와 모델 클래스를 모두 import
import 'package:device_apps_plus/device_apps_plus.dart';
//import 'package:device_apps_plus/model/application.dart';
//import 'package:device_apps_plus/model/application_with_icon.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '내 런처',
      theme: ThemeData.dark(),
      home: const LauncherScreen(),
    );
  }
}

class LauncherScreen extends StatefulWidget {
  const LauncherScreen({super.key});

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

  Future<void> loadApps() async {
    final installedApps = await DeviceAppsPlus.getInstalledApplications(
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
      includeAppIcons: true,
    );
    setState(() {
      apps = installedApps.cast<Application>();
    });
  }

  void launchApp(String packageName) {
    DeviceAppsPlus.openApp(packageName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("내 런처")),
      body: apps.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: apps.length,
              itemBuilder: (context, index) {
                final app = apps[index] as ApplicationWithIcon;
                return GestureDetector(
                  onTap: () => launchApp(app.packageName),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.memory(app.icon, width: 50, height: 50),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        app.appName,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
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