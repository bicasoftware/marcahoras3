import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'domain_layer/contracts.dart';

enum Flavor { offline, online, sqlite, desktop, web }

class AppConfig {
  String appName = '';
  String appVersion = '';
  MaterialColor appColor = Colors.red;
  Flavor flavor = Flavor.online;
  HorasProviderContract? horasProvider;
  EmpregosProviderContract? empregosProvider;
  SalariosProviderContract? salariosProvider;
  DiferenciaisProviderContract? diferenciaisProvider;
  HoraFixoProviderContract? fixoProvider;
  Dio? http;

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
    this.http,
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
    Dio? http,
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
      http,
    );
  }

}
