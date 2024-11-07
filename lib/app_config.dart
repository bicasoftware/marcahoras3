import 'package:flutter/material.dart';

import 'domain_layer/contracts.dart';

enum Flavor { offline, online }

class AppConfig {
  String appName = '';
  String appVersion = '';
  MaterialColor appColor = Colors.red;
  Flavor flavor = Flavor.online;
  HorasProviderContract? horasProvider;
  EmpregosProviderContract? empregosProvider;
  SalariosProviderContract? salariosProvider;

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = '',
    String appVersion = '',
    MaterialColor appColor = Colors.red,
    Flavor flavor = Flavor.online,
    HorasProviderContract? horasProvider,
    EmpregosProviderContract? empregosProvider,
    SalariosProviderContract? salariosProvider,
  }) {
    return shared = AppConfig(
      appName,
      appVersion,
      appColor,
      flavor,
      empregosProvider,
      salariosProvider,
      horasProvider,
    );
  }

  AppConfig(
    this.appName,
    this.appVersion,
    this.appColor,
    this.flavor,
    this.empregosProvider,
    this.salariosProvider,
    this.horasProvider,
  );
}
