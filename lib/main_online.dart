import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:yaml/yaml.dart';

import 'app_config.dart';
import 'data_layer/database/db_connector_drift.dart';
import 'data_layer/providers.dart';
import 'data_layer/web.dart';
import 'main.dart';
import 'utils.dart';

void main() async {
  final mySystemTheme = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: Colors.white,
  );

  SystemChrome.setSystemUIOverlayStyle(mySystemTheme);

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await VaultManager.buildVaultData();

  final connector = WebConnector();
  final database = AppDatabase();

  final y = await rootBundle.loadString('strings.yaml');
  final parsedY = loadYaml(y);
  Localiza().init(parsedY, Platform.localeName);

  AppConfig.create(
    appName: 'Marca Horas',
    appVersion: '0.0.1',
    appColor: Colors.red,
    flavor: Flavor.online,
    empregosProvider: EmpregosProvider(connector),
    horasProvider: HorasProvider(connector: connector),
    salariosProvider: SalariosProvider(connector: connector),
    diferenciaisProvider: DiferenciaisProvider(connector),
    fixoProvider: HoraFixoProvider(connector),
    empregosSqlProvider: EmpregosSqlProvider(db: database),
    horasSqlProvider: HorasSqlProvider(db: database),
    salariosSqlProvider: SalariosSqlProvider(db: database),
    diferenciaisSqlProvider: DiferenciaisSqlProvider(db: database),
    fixoSqlProvider: HoraFixoSqlProvider(db: database),
  );

  runApp(const HorasApp());
}
