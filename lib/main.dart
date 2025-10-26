import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcahoras3/features/home/home/home_screen.dart';

import 'app_config.dart';
import 'features/empregos/empregos_screen.dart';
import 'features/home/calendar/calendar_screen.dart';
import 'features/relatorio/relatorio_screen.dart';
import 'presentation_layer/blocs/empregos/empregos_bloc_loader.dart';
import 'presentation_layer/blocs/home/home_bloc_loader.dart';
import 'resources.dart';
import 'routes.dart';
import 'utils.dart';
import 'widgets/transtions/sh_fade_transition.dart';

class HorasApp extends StatelessWidget {
  const HorasApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        initialRoute: Routes.home,
        routes: {
          Routes.empregosDetail: (_) {
            return EmpregosBlocLoader(child: const EmpregosScreen());
          },
          Routes.relatorio: (_) => const RelatorioScreen(),
          Routes.calendar: (_) => const CalendarScreen(),
          Routes.home: (c) => const HomeScreen(),
        },
        onGenerateRoute: (settings) {
          switch (ERoutes.fromRouteName(settings.name)) {
            case ERoutes.relatorio:
              return ShPageFadeTransition(page: const RelatorioScreen());
            case ERoutes.empregosDetail:
              return ShPageFadeTransition(page: const EmpregosScreen());
            case ERoutes.calendar:
              return ShPageFadeTransition(page: const CalendarScreen());
            case ERoutes.home:
              return ShPageFadeTransition(page: const HomeScreen());
            default:
              null;
          }

          return null;
        },
      ),
    );
  }
}
