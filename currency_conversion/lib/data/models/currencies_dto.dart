import 'package:currency_conversion/domain/entitites/currencies_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currencies_dto.g.dart';

@JsonSerializable()
class CurrenciesDto {
  final bool success;
  final Map<String, String> currencies;

  CurrenciesDto({required this.success, required this.currencies});

  factory CurrenciesDto.fromJson(Map<String, dynamic> json) {
    return _$CurrenciesDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CurrenciesDtoToJson(this);

  CurrenciesEntity toEntity() => CurrenciesEntity(currencies: currencies);
}
