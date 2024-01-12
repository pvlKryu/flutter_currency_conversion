import 'package:currency_conversion/presentation/pages/converter_screen/converter_screen.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test Task',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple.shade900),
        useMaterial3: true,
      ),
      home: const CurrencyConverterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
