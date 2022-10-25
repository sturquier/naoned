import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:naoned/routing.dart';

void main() {
  runApp(const NaonedApp());
}

class NaonedApp extends StatelessWidget {
  static const String _title = 'Naoned';

  const NaonedApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: [Locale('fr', 'FR')],
      home: Routing(),
    );
  }
}
