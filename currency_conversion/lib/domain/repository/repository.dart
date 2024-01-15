import 'package:currency_conversion/domain/entitites/conversion_entity.dart';
import 'package:currency_conversion/domain/entitites/currencies_entity.dart';
import 'package:currency_conversion/domain/entitites/latest_rates_entity.dart';

abstract interface class Repository {
  Future<CurrenciesEntity?> getAvailibleCurrencies();

  Future<ConversionEntity?> makeCurrencyConvert(String fromCurrency, String toCurrency, double amount);

  Future<LatestRatesEntity?> getLatestRate();
}
