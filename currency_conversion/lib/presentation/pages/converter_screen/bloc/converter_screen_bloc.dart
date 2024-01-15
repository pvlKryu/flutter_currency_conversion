import 'package:currency_conversion/domain/entitites/currencies_entity.dart';
import 'package:currency_conversion/domain/use_cases/get_availible_currencies.dart';
import 'package:currency_conversion/domain/use_cases/get_current_rate_base.dart';
import 'package:currency_conversion/domain/use_cases/use_case_result.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:currency_conversion/presentation/pages/converter_screen/bloc/converter_screen_event.dart';
import 'package:currency_conversion/presentation/pages/converter_screen/bloc/converter_screen_state.dart';

class ConverterScreenBloc extends Bloc<ConverterScreenEvent, ConverterScreenState> {
  final GetAvailibleCurrenciesUseCase getAvailibleCurrenciesUseCase;
  final GetCurrentRateBaseUseCase getCurrentRateBaseUseCase;

  ConverterScreenBloc({
    required this.getCurrentRateBaseUseCase,
    required this.getAvailibleCurrenciesUseCase,
  }) : super(ConverterScreenState.initial()) {
    on<GetAvailibleCurrencies>(_getAvailibleCurrencies);
    on<OnRefresh>(_onRefresh);
    on<SaveChoosenCurrency>(_saveChoosenCurrency);
    on<CountRate>(_countRate);
    on<OnChangeFromTo>(_onChangeFromTo);
    add(OnRefresh());
  }

  void _onRefresh(OnRefresh event, Emitter<ConverterScreenState> emit) {
    emit(state.copyWith(isError: false));
    add(GetAvailibleCurrencies());
  }

  void _getAvailibleCurrencies(GetAvailibleCurrencies event, Emitter<ConverterScreenState> emit) async {
    emit(state.copyWith(isLoading: true));

    UseCaseResult result = await getAvailibleCurrenciesUseCase.call();

    if (!result.isSuccesful) {
      emit(state.copyWith(isError: true, isLoading: false));
      return;
    }

    emit(state.copyWith(currenciesEntity: CurrenciesEntity(currencies: result.value), isLoading: false));
  }

  void _saveChoosenCurrency(SaveChoosenCurrency event, Emitter<ConverterScreenState> emit) {
    final String currency = event.shortName;
    final bool isCurrencyEmpty = currency.isEmpty;

    if (event.type == AdressType.from) {
      emit(state.copyWith(
        fromCurrencyChoosen: currency,
        toAmmount: isCurrencyEmpty ? 0.0 : state.toAmmount,
        toCurrencyChoosen: isCurrencyEmpty ? '' : state.toCurrencyChoosen,
      ));
    } else if (event.type == AdressType.to) {
      emit(state.copyWith(
        toCurrencyChoosen: currency,
        toAmmount: isCurrencyEmpty ? 0.0 : state.toAmmount,
      ));
    }
  }

  void _countRate(CountRate event, Emitter<ConverterScreenState> emit) async {
    if (event.ammount <= 0 || state.fromCurrencyChoosen.isEmpty == true || state.toCurrencyChoosen.isEmpty == true) {
      emit(state.copyWith(toAmmount: 0));
      return;
    }

    emit(state.copyWith(isLoading: true));
    UseCaseResult result = await getCurrentRateBaseUseCase.call(
        amount: event.ammount, currencyFrom: state.fromCurrencyChoosen, currencyTo: state.toCurrencyChoosen);

    if (result.isSuccesful) {
      emit(state.copyWith(toAmmount: result.value, isLoading: false));
    } else {
      emit(state.copyWith(isError: true, isLoading: false));
    }
  }

  void _onChangeFromTo(OnChangeFromTo event, Emitter<ConverterScreenState> emit) {
    emit(state.copyWith(
      isError: false,
      fromCurrencyChoosen: state.toCurrencyChoosen,
      toCurrencyChoosen: state.fromCurrencyChoosen,
    ));
  }
}
