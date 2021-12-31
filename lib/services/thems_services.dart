import 'package:demo_of/ui/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final _box = GetStorage();
  final _key = 'isDarkMode';
  void changeTheme(bool val) => _box.write(_key, val);

  bool isDark() => _box.read(_key) ?? false;

  ThemeData get theme => isDark() ? Themes.dark : Themes.light;

  void switchTheme() {
    Get.changeThemeMode(isDark() ? ThemeMode.light : ThemeMode.dark);
    changeTheme(!isDark());
  }

}