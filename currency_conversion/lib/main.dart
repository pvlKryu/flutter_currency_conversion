import 'package:currency_conversion/app.dart';
import 'package:currency_conversion/data/db/models.dart';
import 'package:currency_conversion/di/di.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  final isarInstance = await Isar.open(
    [
      CurrenciesIsarModelSchema,
      CurrencySymbolSchema,
      LatestRatesIsarModelSchema,
      RateSchema,
    ],
    directory: dir.path,
  );
  BaseDi baseDi = BaseDi();
  baseDi.setUp(isarInstance);
  runApp(const MyApp());
}
