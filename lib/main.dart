import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:routine_app/pages/first_page.dart';
import 'package:routine_app/pages/home_page.dart';

import 'package:routine_app/routes/my_routes.dart';
import 'package:routine_app/themes/my_themes.dart';
import 'package:velocity_x/velocity_x.dart';

FlutterSecureStorage token = FlutterSecureStorage();
String? tokenSave;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );
  String? tokenRead = await token.read(key: 'token');
  tokenSave = tokenRead;
  print(tokenRead);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: MyThemes.lightTheme(context),
      darkTheme: MyThemes.darkTheme(context),
      initialRoute:
          tokenSave.isEmptyOrNull ? MyRoutes.firstPage : MyRoutes.homePage,
      routes: {
        MyRoutes.firstPage: (context) => FirstPage(),
        MyRoutes.homePage: (context) => HomePage()
      },
    );
  }
}
