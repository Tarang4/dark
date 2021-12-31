import 'package:demo_of/services/thems_services.dart';
import 'package:demo_of/ui/themes.dart';
import 'package:flutter/material.dart';

import 'ui/home_page.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      darkTheme:Themes.dark,
      themeMode: ThemeMode.light,
      theme: ThemeServices().theme,
      home: const HomePage(),
    );
  }
}
