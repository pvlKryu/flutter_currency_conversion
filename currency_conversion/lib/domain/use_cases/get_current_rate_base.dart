import 'package:currency_conversion/domain/entitites/latest_rates_entity.dart';
import 'package:currency_conversion/domain/repository/repository.dart';
import 'package:currency_conversion/domain/use_cases/use_case_result.dart';

final class GetCurrentRateBaseUseCase {
  final Repository repository;

  GetCurrentRateBaseUseCase({required this.repository});

  Future<UseCaseResult> call({required double amount, required String currencyFrom, required String currencyTo}) async {
    try {
      LatestRatesEntity? result = await repository.getLatestRate();
      if (result?.rates != null) {
        double rate = convertCurrencies(amount, result!.rates, currencyFrom, currencyTo);
        return UseCaseResult(isSuccesful: true, value: rate);
      } else {
        return UseCaseResult(isSuccesful: false, value: null);
      }
    } catch (e) {
      return UseCaseResult(isSuccesful: false, value: null);
    }
  }
}

double convertCurrencies(double amount, Map<String, double> rates, String currencyFrom, String currencyTo) {
  double eurToCurrencyFrom = rates[currencyFrom] ?? 0.0;

  double eurToCurrencyTo = rates[currencyTo] ?? 0.0;

  double amountInEur = amount / eurToCurrencyFrom;

  double convertedAmount = amountInEur * eurToCurrencyTo;

  return double.parse(convertedAmount.toStringAsFixed(5));
}
