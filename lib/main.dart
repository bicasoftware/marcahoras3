import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcahoras3/presentation_layer/blocs/registration/registration_bloc_loader.dart';

import 'app_config.dart';
import 'features/empregos/empregos_screen.dart';
import 'features/home/calendar/calendar_screen.dart';
import 'features/registration/login/login_screen.dart';
import 'features/registration/register/register_screen.dart';
import 'features/relatorio/relatorio_screen.dart';
import 'presentation_layer/blocs/empregos/empregos_bloc_loader.dart';
import 'presentation_layer/blocs/home/home_bloc_loader.dart';
import 'resources.dart';
import 'routes.dart';
import 'utils.dart';
import 'widgets/transtions/sh_fade_transition.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class HorasApp extends StatelessWidget {
  const HorasApp({super.key});

  @override
  Widget build(BuildContext context) {
    final vault = Vault();
    return HomeBlocLoader(
      child: MaterialApp(
        title: "Horas Extras",
        locale: PlatformDispatcher.instance.locale, // Access device's locale
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        theme: ThemeData(
          primaryColor: AppConfig.shared.appColor,
          fontFamily: 'Outfit',
          useMaterial3: true,
          colorScheme: lightColorScheme,
          appBarTheme: appBarColorScheme,
          textTheme: TextTheme(
            labelLarge: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 14,
              fontFamily: 'Outfit',
            ),
          ),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
        initialRoute: _getMainRoute(vault),
        routes: {
          Routes.registration: (_) {
            return RegistrationBlocLoader(child: RegisterScreen());
          },
          Routes.login: (_) {
            return RegistrationBlocLoader(child: LoginScreen());
          },
          Routes.empregosDetail: (_) {
            return EmpregosBlocLoader(child: const EmpregosScreen());
          },
          Routes.relatorio: (_) => const RelatorioScreen(),
          Routes.calendar: (_) => const CalendarScreen(),
        },
        onGenerateRoute: (settings) {
          switch (ERoutes.fromRouteName(settings.name)) {
            case ERoutes.relatorio:
              return ShPageFadeTransition(page: const RelatorioScreen());
            case ERoutes.empregosDetail:
              return ShPageFadeTransition(page: const EmpregosScreen());
            case ERoutes.registration:
              return ShPageFadeTransition(page: const RegisterScreen());
            case ERoutes.login:
              return ShPageFadeTransition(page: const LoginScreen());
            case ERoutes.calendar:
              return ShPageFadeTransition(page: const CalendarScreen());
            default:
              null;
          }

          return null;
        },
      ),
    );
  }

  String _getMainRoute(Vault vault) {
    if (AppConfig.shared.flavor == Flavor.online) {
      return vault.isLoggedIn ? Routes.calendar : Routes.registration;
    }

    return Routes.calendar;
  }
}
