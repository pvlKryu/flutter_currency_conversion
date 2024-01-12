import 'package:currency_conversion/data/models/currencies_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api.g.dart';

@RestApi(baseUrl: "https://api.exchangeratesapi.io/v1/")
abstract interface class Api {
  factory Api(Dio dio, {String baseUrl}) = _Api;

  @GET("/symbols")
  Future<CurrenciesDto> getAvailableCurrencies(@Query("access_key") String apiKey);
}
