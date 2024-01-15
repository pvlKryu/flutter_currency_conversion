import 'package:currency_conversion/domain/entitites/latest_rates_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'latest_rates_dto.g.dart';

@JsonSerializable(createToJson: false) 
class LatestRatesDto {
  final bool success;
  final String base;

  final Map<String, double> rates;
  final String? error;

  LatestRatesDto({
    required this.success,
    required this.base,
    required this.rates,
    this.error,
  });

  factory LatestRatesDto.fromJson(Map<String, dynamic> json) => _$LatestRatesDtoFromJson(json);

  LatestRatesEntity toEntity() {
    return LatestRatesEntity(
      rates: rates,
    );
  }
}
