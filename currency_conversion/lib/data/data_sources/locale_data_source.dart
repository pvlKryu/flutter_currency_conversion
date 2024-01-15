import 'package:currency_conversion/data/db/models.dart';
import 'package:currency_conversion/data/models/currencies_dto.dart';
import 'package:currency_conversion/data/models/latest_rates_dto.dart';
import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

abstract interface class LocalDataSource {
  /// currencies
  Future<CurrenciesDto?> getAvailibleCurrencies();
  Future<void> saveAvailibleCurrencies(CurrenciesDto currencies);
  Future<void> updateAvailibleCurrencies(CurrenciesDto currencies);

  /// rates
  Future<LatestRatesDto?> getLatestRate();
  Future<void> saveLatestRate(LatestRatesDto rates);
  Future<void> updateLatestRate(LatestRatesDto rates);

  /// Do not use
  Future<bool> isDbEmpty();
}

final class LocalDataSourceImpl implements LocalDataSource {
  final Isar isar;
  LocalDataSourceImpl({required this.isar});

  @override
  Future<CurrenciesDto?> getAvailibleCurrencies() async {
    try {
      final models = await isar.currenciesIsarModels.where().findAll();
      if (models.isEmpty) return null;

      Map<String, String> symbols = {};
      for (var model in models) {
        await model.symbols.load();
        for (var symbol in model.symbols) {
          symbols[symbol.key] = symbol.value;
        }
      }

      return CurrenciesDto(success: true, symbols: symbols);
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching available currencies from DB: $e');
      }
      return null;
    }
  }

  @override
  Future<LatestRatesDto?> getLatestRate() async {
    final models = await isar.rates.where().findAll();
    if (models.isEmpty) return null;

    Map<String, double> rates = {};
    for (var rate in models) {
      rates[rate.currency] = rate.value;
    }

    return LatestRatesDto(success: true, base: 'EUR', rates: rates);
  }

  @override
  Future<void> saveLatestRate(LatestRatesDto ratesDto) async {
    await isar.writeTxn(() async {
      final model = LatestRatesIsarModel()..base = ratesDto.base;
      for (var entry in ratesDto.rates.entries) {
        final rate = Rate()
          ..currency = entry.key
          ..value = entry.value;
        await isar.rates.put(rate);
        model.rates.add(rate);
      }
      await isar.latestRatesIsarModels.put(model);
    });
  }

  @override
  Future<void> saveAvailibleCurrencies(CurrenciesDto currenciesDto) async {
    await isar.writeTxn(() async {
      final model = CurrenciesIsarModel();
      for (var entry in currenciesDto.symbols.entries) {
        final symbol = CurrencySymbol()
          ..key = entry.key
          ..value = entry.value;
        await isar.currencySymbols.put(symbol);
        model.symbols.add(symbol);
      }
      await isar.currenciesIsarModels.put(model);
    });
  }

  @override
  Future<void> updateAvailibleCurrencies(CurrenciesDto currencies) async {
    await isar.writeTxn(() async {
      await isar.currencySymbols.clear();
      await isar.currenciesIsarModels.clear();

      final model = CurrenciesIsarModel();
      for (var entry in currencies.symbols.entries) {
        final symbol = CurrencySymbol()
          ..key = entry.key
          ..value = entry.value;
        await isar.currencySymbols.put(symbol);
        model.symbols.add(symbol);
      }
      await isar.currenciesIsarModels.put(model);
    });
  }

  @override
  Future<void> updateLatestRate(LatestRatesDto rates) async {
    await isar.writeTxn(() async {
      await isar.rates.clear();
      await isar.latestRatesIsarModels.clear();

      final model = LatestRatesIsarModel()..base = rates.base;
      for (var entry in rates.rates.entries) {
        final rate = Rate()
          ..currency = entry.key
          ..value = entry.value;
        await isar.rates.put(rate);
        model.rates.add(rate);
      }
      await isar.latestRatesIsarModels.put(model);
    });
  }

  /// Do not used
  @override
  Future<bool> isDbEmpty() async {
    final currenciesCount = await isar.currenciesIsarModels.where().count();
    final ratesCount = await isar.latestRatesIsarModels.where().count();
    return currenciesCount == 0 && ratesCount == 0;
  }
}
