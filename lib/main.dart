import 'package:connection_coach/screens/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ConnectionCoachApp());
}

class ConnectionCoachApp extends StatelessWidget {
  const ConnectionCoachApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Connection Coach',
      theme: ThemeData.dark(),
      home: const HomePage(),
    );
  }
}
