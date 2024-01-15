import 'package:currency_conversion/data/models/conversion_dto.dart';
import 'package:currency_conversion/data/models/currencies_dto.dart';
import 'package:currency_conversion/data/models/latest_rates_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: "http://api.exchangeratesapi.io/v1/")
abstract interface class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @GET("/symbols")
  Future<CurrenciesDto> getAvailableCurrencies(@Query("access_key") String apiKey);

  /// Unavailible for free API KEY
  @GET("/convert")
  Future<ConversionDto> getConversionRate(
    @Query("access_key") String apiKey,
    @Query("from") String fromCurrency,
    @Query("to") String toCurrency,
    @Query("amount") double amount,
  );

  @GET("/latest")
  Future<LatestRatesDto> getLatestExchangeRates(
    @Query("access_key") String apiKey,
    // Optionally
    // @Query("base") String baseCurrency,
    // @Query("symbols") String symbols,
  );
}
