import 'package:flutter/material.dart';

import 'data_layer/database/db_connector_drift.dart';
import 'data_layer/web/web.dart';
import 'domain_layer/contracts.dart';

enum Flavor { offline, online, sqlite, desktop, web }

class AppConfig {
  String appName = '';
  String appVersion = '';
  MaterialColor appColor = Colors.red;
  Flavor flavor = Flavor.online;
  HorasProviderContract? horasProvider, horasSqlProvider;
  EmpregosProviderContract? empregosProvider, empregosSqlProvider;
  SalariosProviderContract? salariosProvider, salariosSqlProvider;
  DiferenciaisProviderContract? diferenciaisProvider, diferenciaisSqlProvider;
  HoraFixoProviderContract? fixoProvider, fixoSqlProvider;
  AppDatabase? db;
  WebConnector? connector;

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
    this.empregosSqlProvider,
    this.salariosSqlProvider,
    this.horasSqlProvider,
    this.diferenciaisSqlProvider,
    this.fixoSqlProvider,
    this.db,
    this.connector,
  );

  static AppConfig shared = AppConfig.create();

  factory AppConfig.create({
    String appName = '',
    String appVersion = '',
    MaterialColor appColor = Colors.red,
    Flavor flavor = Flavor.online,
    HorasProviderContract? horasProvider,
    HorasProviderContract? horasSqlProvider,
    EmpregosProviderContract? empregosProvider,
    EmpregosProviderContract? empregosSqlProvider,
    SalariosProviderContract? salariosProvider,
    SalariosProviderContract? salariosSqlProvider,
    DiferenciaisProviderContract? diferenciaisProvider,
    DiferenciaisProviderContract? diferenciaisSqlProvider,
    HoraFixoProviderContract? fixoProvider,
    HoraFixoProviderContract? fixoSqlProvider,
    AppDatabase? db,
    WebConnector? connector,
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
      empregosSqlProvider,
      salariosSqlProvider,
      horasSqlProvider,
      diferenciaisSqlProvider,
      fixoSqlProvider,
      db,
      connector,
    );
  }
}
