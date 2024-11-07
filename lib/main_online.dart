import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'app_config.dart';
import 'data_layer/providers.dart';
import 'data_layer/web.dart';
import 'main.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await VaultManager.buildVaultData();

  final connector = WebConnector();

  connector.addInterceptor(
    InvalidUserInterceptor(),
  );

  final vault = Vault();
  connector.token = vault.token;

  AppConfig.create(
    appName: 'Marca Horas',
    appVersion: '0.0.1',
    appColor: Colors.red,
    flavor: Flavor.online,
    empregosProvider: EmpregosProvider(connector),
    horasProvider: HorasProvider(connector: connector),
    salariosProvider: SalariosProvider(connector: connector),
  );

  runApp(
    const HorasApp(),
  );
}
