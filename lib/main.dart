import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:month_year_picker/month_year_picker.dart';

import 'bloc_loader.dart';
import 'features/empregos/empregos/empregos_screen.dart';
import 'features/empregos/empregos_detail_screen.dart';
import 'features/home/home.dart';
import 'features/registration/login/login_screen.dart';
import 'features/registration/register/register_screen.dart';
import 'resources.dart';
import 'routes.dart';
import 'utils/utils.dart';
import 'utils/vault/vault_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await _buildVaultData();

  runApp(
    const MyApp(),
  );
}

Future<void> _buildVaultData() async {
  final vaultMan = VaultManager();
  final token = await vaultMan.readValue(VaultKeys.accessToken);
  final refreshToken = await vaultMan.readValue(VaultKeys.refreshToken);

  final vault = Vault();
  vault.setVaultData(
    token: token ?? '',
    refreshToken: refreshToken ?? '',
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vault = Vault();
    return BlocLoader(
      child: MaterialApp(
        title: "Horas Extras",
        locale: PlatformDispatcher.instance.locale, // Access device's locale
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          fontFamily: 'FiraSans',
          useMaterial3: true,
          colorScheme: lightColorScheme,
          appBarTheme: appBarColorScheme,
          textTheme: TextTheme(
            labelLarge: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          MonthYearPickerLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', 'BR'),
          Locale('en', 'US'),
        ],
        initialRoute: vault.isLoggedIn ? Routes.home : Routes.registration,
        routes: {
          Routes.home: (_) => const MyHomePage(),
          Routes.registration: (_) => const RegisterScreen(),
          Routes.login: (_) => const LoginScreen(),
          Routes.empregos: (_) => const EmpregosScreen(),
          Routes.empregosDetail: (_) => const EmpregosDetailScreen(),
        },
      ),
    );
  }
}
