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
        onGenerateRoute: (s) {
          switch (s.name) {
            case Routes.calendar:
              return ShPageFadeTransition(
                page: CalendarScreen(),
                settings: s,
              );
            case Routes.empregosDetail:
              return ShPageFadeTransition(
                page: EmpregosBlocLoader(child: const EmpregosScreen()),
                settings: s,
              );
            case Routes.empregos:
              return MaterialPageRoute(
                builder: (_) => const EmpregosListScreen(),
              );
            case Routes.relatorio:
              return ShPageFadeTransition(
                page: const RelatorioScreen(),
                settings: s,
              );
            default:
              return MaterialPageRoute(builder: (_) => HomeScreen());
          }
        },
      ),
    );
  }
}
