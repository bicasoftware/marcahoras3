import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'presentation_layer/blocs.dart';
import 'resources.dart';
import 'routes.dart';
import 'screens.dart';
import 'utils.dart';
import 'widgets.dart';

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
        theme: ShAppTheme(
          textTheme: ShTextTheme('Outfit').textTheme(),
        ).theme(ShAppTheme.lightScheme()),
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
          Routes.empregos: (_) {
            return const EmpregosListScreen();
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
