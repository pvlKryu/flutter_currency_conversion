import 'package:currency_conversion/domain/repository/repository.dart';
import 'package:currency_conversion/domain/use_cases/use_case_result.dart';

class GetAvailibleCurrenciesUseCase {
  final Repository _repository;

  GetAvailibleCurrenciesUseCase(this._repository);

  Future<UseCaseResult> call() async {
    var result = await _repository.fetchAvailibleCurrencies();
    if (result.currencies.isNotEmpty) {
      return UseCaseResult(isSuccesful: true, result: result.currencies);
    } else {
      return UseCaseResult(isSuccesful: false, result: null);
    }
  }
}
