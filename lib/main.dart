import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:marcahoras3/opa/opa.dart';
import 'package:marcahoras3/presentation_layer/resources/color_scheme.dart';
import 'package:marcahoras3/strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'bloc_loader.dart';
import 'features/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: OpaConstants.leHost,
    anonKey: OpaConstants.leKey,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        appBarTheme: appBarColorScheme,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('pt'),
        Locale('es'),
      ],
      home: const BlocLoader(
        child: MyHomePage(),
      ),
    );
  }
}
