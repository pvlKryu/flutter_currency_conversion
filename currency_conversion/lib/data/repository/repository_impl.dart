import 'package:connectivity/connectivity.dart';
import 'package:currency_conversion/data/data_sources/locale_data_source.dart';
import 'package:currency_conversion/data/data_sources/remote_data_source.dart';
import 'package:currency_conversion/domain/entitites/conversion_entity.dart';
import 'package:currency_conversion/domain/entitites/currencies_entity.dart';
import 'package:currency_conversion/domain/entitites/latest_rates_entity.dart';
import 'package:currency_conversion/domain/repository/repository.dart';
import 'package:flutter/foundation.dart';

final class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSourse;

  /// todo better not to keep API key here => make a config
  static const String apiKey = '416f69e828c53d43d055fa1925be1ac6';

  bool _wasConnectLost = false;
  bool _hasLocalCurrenciesData = false;
  bool _hasLocalRatesData = false;

  RepositoryImpl({required this.remoteDataSource, required this.localDataSourse});

  /// Get currencies
  @override
  Future<CurrenciesEntity?> getAvailibleCurrencies() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        if (kDebugMode) {
          print('Connected to internet');
        }
        final currencies = await remoteDataSource.fetchAvailibleCurrencies(apiKey);

        if ((!_hasLocalCurrenciesData || _wasConnectLost) && currencies != null) {
          localDataSourse.updateAvailibleCurrencies(currencies);
          _hasLocalCurrenciesData = true;
          _wasConnectLost = false;
        }

        return currencies?.toEntity();
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching from remote source: $e');
        }
        _wasConnectLost = true;
      }
    } else {
      _wasConnectLost = true;
      if (kDebugMode) {
        print('Using local data source');
      }
    }

    final currencies = await localDataSourse.getAvailibleCurrencies();
    if (currencies != null) {
      _hasLocalCurrenciesData = true;
    }
    return currencies?.toEntity();
  }

  /// not used cos free api limits
  @override
  Future<ConversionEntity?> makeCurrencyConvert(String fromCurrency, String toCurrency, double amount) async {
    final conversion = await remoteDataSource.convertCurrency(apiKey, fromCurrency, toCurrency, amount);
    return conversion?.toEntity();
  }

  /// get rates
  @override
  Future<LatestRatesEntity?> getLatestRate() async {
    var connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      try {
        if (kDebugMode) {
          print('Connected to internet');
        }
        final rates = await remoteDataSource.getLatestRate(apiKey);

        if ((!_hasLocalRatesData || _wasConnectLost) && rates != null) {
          localDataSourse.updateLatestRate(rates);
          _hasLocalRatesData = true;
          _wasConnectLost = false;
        }

        return rates?.toEntity();
      } catch (e) {
        if (kDebugMode) {
          print('Error fetching from remote source: $e');
        }
        _wasConnectLost = true;
      }
    } else {
      _wasConnectLost = true;
      if (kDebugMode) {
        print('Using local data source');
      }
    }

    final rates = await localDataSourse.getLatestRate();
    if (rates != null) {
      _hasLocalRatesData = true;
    }
    return rates?.toEntity();
  }
}
