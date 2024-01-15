sealed class ConverterScreenEvent {}

class GetAvailibleCurrencies extends ConverterScreenEvent {}

class OnRefresh extends ConverterScreenEvent {}

class OnChangeFromTo extends ConverterScreenEvent {}

class SaveChoosenCurrency extends ConverterScreenEvent {
  final String shortName;
  final AdressType type;

  SaveChoosenCurrency({required this.shortName, required this.type});
}

enum AdressType { from, to }

class CountRate extends ConverterScreenEvent {
  final double ammount;

  CountRate({required this.ammount});
}
