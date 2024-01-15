import 'package:currency_conversion/data/models/conversion_dto.dart';
import 'package:currency_conversion/data/models/currencies_dto.dart';
import 'package:currency_conversion/data/models/latest_rates_dto.dart';
import 'package:currency_conversion/data/network/api.dart';

abstract interface class RemoteDataSource {
  /// Get currencies
  Future<CurrenciesDto?> fetchAvailibleCurrencies(String apiKey);

  /// Not availible by free API
  Future<ConversionDto?> convertCurrency(String apiKey, String fromCurrency, String toCurrency, double amount);

  /// Get current rates
  Future<LatestRatesDto?> getLatestRate(String apiKey);
}

final class RemoteDataSourceImpl implements RemoteDataSource {
  final Api api;

  RemoteDataSourceImpl({
    required this.api,
  });

  @override
  Future<CurrenciesDto?> fetchAvailibleCurrencies(String apiKey) {
    return api.getAvailableCurrencies(apiKey);
  }

  @override
  Future<ConversionDto?> convertCurrency(String apiKey, String fromCurrency, String toCurrency, double amount) {
    return api.getConversionRate(apiKey, fromCurrency, toCurrency, amount);
  }

  @override
  Future<LatestRatesDto?> getLatestRate(String apiKey) {
    return api.getLatestExchangeRates(apiKey);
  }
}
