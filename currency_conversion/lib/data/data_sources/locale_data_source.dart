import 'package:currency_conversion/data/models/currencies_dto.dart';
import 'package:currency_conversion/data/network/api.dart';

abstract interface class LocalDataSource {
  /// Получение валют
  Future<CurrenciesDto> fetchAvailibleCurrencies(String apiKey);
}

final class RemoteDataSourceImpl implements LocalDataSource {
  final Api api;

  RemoteDataSourceImpl({
    required this.api,
  });
  
  @override
  Future<CurrenciesDto> fetchAvailibleCurrencies(String apiKey) {
    // TODO: implement fetchAvailibleCurrencies
    throw UnimplementedError();
  }

  
}
