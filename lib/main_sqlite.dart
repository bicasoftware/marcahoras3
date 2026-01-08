import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yaml/yaml.dart';

import 'app_config.dart';
import 'data_layer/database/db_connector_drift.dart';
import 'data_layer/providers.dart';
import 'main.dart';
import 'resources.dart';
import 'utils/localiza/localiza.dart';
import 'utils/vault/vault_manager.dart';

void main() async {
  final mySystemTheme = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: ExtraColors.tabBarBgColor,
  );

  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);

  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await VaultManager.buildVaultData();
  final database = AppDatabase();

  final y = await rootBundle.loadString('strings.yaml');
  final parsedY = loadYaml(y);
  Localiza().init(parsedY, Platform.localeName);

  AppConfig.create(
    appName: 'Marca Horas - Sqlite',
    appVersion: '0.0.1',
    appColor: Colors.indigo,
    flavor: Flavor.sqlite,
    salariosProvider: SalariosProvider(db: database),
    horasProvider: HorasProvider(db: database),
    empregosProvider: EmpregosProvider(db: database),
    diferenciaisProvider: DiferenciaisProvider(db: database),
    fixoProvider: HoraFixoProvider(db: database),
    db: database,
  );

  FlutterNativeSplash.remove();

  runApp(const HorasApp());
}
