import 'package:currency_conversion/data/data_sources/remote_data_source.dart';
import 'package:currency_conversion/domain/entitites/currencies_entity.dart';
import 'package:currency_conversion/domain/repository/repository.dart';

final class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final String apiKey;

  RepositoryImpl({required this.remoteDataSource, required this.apiKey});

  /// Получение валют
  @override
  Future<CurrenciesEntity> fetchAvailibleCurrencies() async {
    final currencies = await remoteDataSource.fetchAvailibleCurrencies(apiKey);
    return currencies.toEntity();
  }
}
