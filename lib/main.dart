import 'package:flutter/material.dart';
import 'package:naoned/config/routing.dart';

void main() {
  runApp(const NaonedApp());
}

class NaonedApp extends StatelessWidget {
  const NaonedApp({Key? key}) : super(key: key);

  static const String _title = 'Naoned';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: Routing(),
    );
  }
}
