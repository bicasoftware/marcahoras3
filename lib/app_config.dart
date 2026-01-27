import 'package:flutter/material.dart';

import 'data_layer/database/db_connector_drift.dart';
import 'data_layer/contracts.dart';

enum Flavor { offline, online, sqlite, desktop, web }

class AppConfig {
  String appName = '';
  String appVersion = '';
  MaterialColor appColor = Colors.red;
  Flavor flavor = Flavor.offline;
  HorasProviderContract? horasProvider;
  EmpregosProviderContract? empregosProvider;
  SalariosProviderContract? salariosProvider;
  DiferenciaisProviderContract? diferenciaisProvider;
  HoraFixoProviderContract? fixoProvider;
  AppDatabase? db;

  AppConfig(
    this.appName,
    this.appVersion,
    this.appColor,
    this.flavor,
    this.empregosProvider,
    this.salariosProvider,
    this.horasProvider,
    this.diferenciaisProvider,
    this.fixoProvider,
    this.db,
  );

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = '',
    String appVersion = '',
    MaterialColor appColor = Colors.red,
    Flavor flavor = Flavor.online,
    HorasProviderContract? horasProvider,    
    EmpregosProviderContract? empregosProvider,
    SalariosProviderContract? salariosProvider,
    DiferenciaisProviderContract? diferenciaisProvider,
    HoraFixoProviderContract? fixoProvider,
    AppDatabase? db,
  }) {
    return shared = AppConfig(
      appName,
      appVersion,
      appColor,
      flavor,
      empregosProvider,
      salariosProvider,
      horasProvider,
      diferenciaisProvider,
      fixoProvider,
      db,
    );
  }
}
