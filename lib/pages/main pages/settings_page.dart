import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:routine_app/routes/my_routes.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  FlutterSecureStorage storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () async {
                    await storage.deleteAll();
                    Navigator.pushNamed(context, MyRoutes.firstPage);
                  },
                  child: Text("Log Out"))
            ],
          ),
        ),
      ),
    );
  }
}
