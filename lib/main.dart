import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcahoras3/features/home/home.dart';
import 'package:marcahoras3/presentation_layer/resources/color_scheme.dart';
import 'package:marcahoras3/presentation_layer/resources/localizations/strings_data.dart';

import 'bloc_loader.dart';
import 'features/empregos/empregos_screen.dart';
import 'features/registration/registration_view.dart';
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocLoader(
      child: MaterialApp(
        title: "Horas Extras",
        debugShowCheckedModeBanner: false,
        theme: mrAppTheme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'),
          Locale('pt', 'BR'),
        ],
        locale: const Locale('pt'),
        initialRoute: Routes.registration,
        routes: {
          Routes.home: (_) => const MyHomePage(),
          Routes.registration: (_) => const RegistrationView(),
          // Routes.login: (_) => const LoginScreen(),
          Routes.empregos: (_) => const EmpregosScreen(),
        },
      ),
    );
  }
}
