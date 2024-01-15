import 'package:currency_conversion/domain/entitites/conversion_entity.dart';
import 'package:currency_conversion/domain/repository/repository.dart';
import 'package:currency_conversion/domain/use_cases/use_case_result.dart';

/// not actual due to FREE API limitations
final class GetCurrentRateUseCase {
  final Repository repository;

  GetCurrentRateUseCase({required this.repository});

  Future<UseCaseResult> call({required String fromCurrency, required String toCurrency, required double amount}) async {
    try {
      ConversionEntity? result = await repository.makeCurrencyConvert(fromCurrency, toCurrency, amount);
      if (result?.resultAmmount != null) {
        return UseCaseResult(isSuccesful: true, value: result!.resultAmmount);
      } else {
        return UseCaseResult(isSuccesful: false, value: null);
      }
    } catch (e) {
      return UseCaseResult(isSuccesful: false, value: null);
    }
  }
}
