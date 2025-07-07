import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:yaml/yaml.dart';

import 'app_config.dart';
import 'data_layer/database/db_connector_drift.dart';
import 'data_layer/providers.dart';
import 'main.dart';
import 'resources/colors.dart';
import 'utils/localiza/localiza.dart';
import 'utils/vault/vault_manager.dart';

void main() async {
  final mySystemTheme = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: AppColors.background,
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
    salariosProvider: SalariosSqlProvider(db: database),
    horasProvider: HorasSqlProvider(db: database),
    empregosProvider: EmpregosSqlProvider(db: database),
    diferenciaisProvider: DiferenciaisSqlProvider(db: database),
    fixoProvider: HoraFixoSqlProvider(db: database),
    db: database,
  );

  FlutterNativeSplash.remove();

  runApp(const HorasApp());
}
