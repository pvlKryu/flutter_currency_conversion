import 'package:currency_conversion/domain/entitites/currencies_entity.dart';
import 'package:currency_conversion/domain/repository/repository.dart';
import 'package:currency_conversion/domain/use_cases/use_case_result.dart';

final class GetAvailibleCurrenciesUseCase {
  final Repository repository;

  GetAvailibleCurrenciesUseCase({required this.repository});

  Future<UseCaseResult> call() async {
    try {
      CurrenciesEntity? result = await repository.getAvailibleCurrencies();
      if (result?.currencies != null) {
        return UseCaseResult(isSuccesful: true, value: result!.currencies);
      } else {
        return UseCaseResult(isSuccesful: false, value: null);
      }
    } catch (e) {
      return UseCaseResult(isSuccesful: false, value: null);
    }
  }
}
