import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:realm/realm.dart';

import 'app_config.dart';
import 'data_layer/providers.dart';
import 'data_layer/tables/realm_models.dart';
import 'main.dart';
import 'utils/vault/vault_manager.dart';

void main() async {
  print('offline app running');
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await dotenv.load(fileName: "assets/.env");
  await VaultManager.buildVaultData();
  final config = Configuration.local(
    [
      EmpregosRealm.schema,
      HorasRealm.schema,
      SalariosRealm.schema,
    ],
    schemaVersion: 2,
  );

  final realm = Realm(config);

  AppConfig.create(
    appName: 'Marca Horas - Offline',
    appVersion: '0.0.1',
    appColor: Colors.indigo,
    flavor: Flavor.offline,
    salariosProvider: SalariosDbProvider(realm: realm),
    horasProvider: HorasDbProvider(realm: realm),
    empregosProvider: EmpregosDbProvider(realm: realm),
  );

  FlutterNativeSplash.remove();

  runApp(
    const HorasApp(),
  );
}
