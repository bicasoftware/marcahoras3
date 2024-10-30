import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:marcahoras3/main.dart';

import 'app_config.dart';
import 'utils/utils.dart';

void main() async {
  print('offline app running');  
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "assets/.env");
  await VaultManager.buildVaultData();

  AppConfig.create(
    appName: 'Marca Horas - Offline',
    appVersion: '0.0.1',
    appColor: Colors.indigo,
    flavor: Flavor.offline,
  );

  runApp(
    const HorasApp(),
  );
}
