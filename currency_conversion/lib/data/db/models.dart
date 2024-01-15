import 'package:isar/isar.dart';

part 'models.g.dart';

@Collection()
class CurrenciesIsarModel {
  Id id = Isar.autoIncrement;

  final symbols = IsarLinks<CurrencySymbol>();
}

@Collection()
class CurrencySymbol {
  Id id = Isar.autoIncrement;

  late String key;
  late String value;
}

@Collection()
class LatestRatesIsarModel {
  Id id = Isar.autoIncrement;

  late String base;
  final rates = IsarLinks<Rate>();
}

@Collection()
class Rate {
  Id id = Isar.autoIncrement;

  late String currency;
  late double value;
}

