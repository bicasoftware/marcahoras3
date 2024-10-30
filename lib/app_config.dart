import 'package:flutter/material.dart';

enum Flavor { offline, online }

class AppConfig {
  String appName = '';
  String appVersion = '';
  MaterialColor appColor = Colors.red;
  Flavor flavor = Flavor.online;

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = '',
    String appVersion = '',
    MaterialColor appColor = Colors.red,
    Flavor flavor = Flavor.online,
  }) {
    return shared = AppConfig(appName, appVersion, appColor, flavor);
  }

  AppConfig(this.appName, this.appVersion, this.appColor, this.flavor);
}
