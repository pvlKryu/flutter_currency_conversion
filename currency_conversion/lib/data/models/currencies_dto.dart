import 'package:currency_conversion/domain/entitites/currencies_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'currencies_dto.g.dart';

@JsonSerializable(createToJson: false) 
class CurrenciesDto {
  final bool success;

  final Map<String, String> symbols;

  CurrenciesDto({required this.success, required this.symbols});

  factory CurrenciesDto.fromJson(Map<String, dynamic> json) {
    return _$CurrenciesDtoFromJson(json);
  }

  CurrenciesEntity toEntity() => CurrenciesEntity(currencies: symbols);
}
