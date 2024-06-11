import 'package:flutter/material.dart';
import 'package:flutter_application_example/dummy.dart';
import 'package:flutter_application_example/main_control.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Dummy()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'NotoSansThaiLooped',
        brightness: Brightness.light,
        /* light theme settings */
      ),
      darkTheme: ThemeData(
        fontFamily: 'NotoSansThaiLooped',
        brightness: Brightness.dark,
        /* dark theme settings */
      ),
      themeMode: ThemeMode.dark,
      home: const MainControl(),
    );
  }
}
