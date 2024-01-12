import 'package:currency_conversion/domain/entitites/currencies_entity.dart';

abstract interface class Repository {
  Future<CurrenciesEntity> fetchAvailibleCurrencies();
}
