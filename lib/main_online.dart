import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marcahoras3/app_config.dart';
import 'package:marcahoras3/main.dart';

import 'utils/utils.dart';

void main() async {
  print('online app running');
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await VaultManager.buildVaultData();

  AppConfig.create(
    appName: 'Marca Horas',
    appVersion: '0.0.1',
    appColor: Colors.red,
    flavor: Flavor.online,
  );

  runApp(
    const HorasApp(),
  );
}
