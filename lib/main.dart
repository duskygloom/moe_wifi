import 'package:flutter/material.dart';
import 'package:moe_wifi/core/main_theme.dart';
import 'package:moe_wifi/model/appdir.dart';
import 'package:moe_wifi/model/config_storage.dart';
import 'package:moe_wifi/model/form_keys.dart';
import 'package:moe_wifi/model/refresh_keys.dart';
import 'package:moe_wifi/model/user_storage.dart';
import 'package:moe_wifi/view/home.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appdir = await getApplicationSupportDirectory();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => Appdir(appdir.path)),
        Provider(create: (context) => FormKeys()),
        Provider(create: (context) => RefreshKeys()),
        ChangeNotifierProvider(create: (context) => UserStorage(appdir.path)),
        ChangeNotifierProvider(create: (context) => ConfigStorage(appdir.path)),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
      theme: MainTheme.lightTheme,
      darkTheme: MainTheme.darkTheme,
      themeMode: ThemeMode.system,
    );
  }
}
