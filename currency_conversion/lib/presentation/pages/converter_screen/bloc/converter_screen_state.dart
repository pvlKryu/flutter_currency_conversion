import 'package:currency_conversion/domain/entitites/currencies_entity.dart';
import 'package:equatable/equatable.dart';

class ConverterScreenState extends Equatable {
  final CurrenciesEntity? currenciesEntity;
  final bool isLoading;
  final bool isError;
  final String fromCurrencyChoosen;
  final String toCurrencyChoosen;
  final double? fromAmmount;
  final double? toAmmount;

  const ConverterScreenState._({
    this.currenciesEntity,
    this.isLoading = false,
    this.isError = false,
    this.fromAmmount,
    this.toAmmount,
    this.fromCurrencyChoosen = '',
    this.toCurrencyChoosen = '',
  });

  factory ConverterScreenState.initial() {
    return const ConverterScreenState._();
  }

  ConverterScreenState copyWith({
    CurrenciesEntity? currenciesEntity,
    bool? isLoading,
    bool? isError,
    String? fromCurrencyChoosen,
    String? toCurrencyChoosen,
    double? fromAmmount,
    double? toAmmount,
  }) {
    return ConverterScreenState._(
      currenciesEntity: currenciesEntity ?? this.currenciesEntity,
      isLoading: isLoading ?? this.isLoading,
      isError: isError ?? this.isError,
      fromCurrencyChoosen: fromCurrencyChoosen ?? this.fromCurrencyChoosen,
      toCurrencyChoosen: toCurrencyChoosen ?? this.toCurrencyChoosen,
      fromAmmount: fromAmmount ?? this.fromAmmount,
      toAmmount: toAmmount ?? this.toAmmount,
    );
  }

  @override
  List<Object?> get props =>
      [currenciesEntity, isLoading, isError, fromCurrencyChoosen, toCurrencyChoosen, fromAmmount, toAmmount];
}
