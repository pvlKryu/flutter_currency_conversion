import 'package:currency_conversion/domain/entitites/conversion_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'conversion_dto.g.dart';

/// Do not used
@JsonSerializable(createToJson: false) 
class ConversionDto {
  final bool success;
  final String query;
  final double result;

  ConversionDto({
    required this.success,
    required this.query,
    required this.result,
  });

  factory ConversionDto.fromJson(Map<String, dynamic> json) => _$ConversionDtoFromJson(json);

  ConversionEntity toEntity() => ConversionEntity(resultAmmount: result);
}
