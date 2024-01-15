import 'package:currency_conversion/domain/entitites/currencies_entity.dart';
import 'package:currency_conversion/presentation/pages/converter_screen/bloc/converter_screen_bloc.dart';
import 'package:currency_conversion/presentation/pages/converter_screen/bloc/converter_screen_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> showCurrencySelectionDialog(BuildContext context, CurrenciesEntity currencies, AdressType type) async {
  String? selectedCurrencyCode = (type == AdressType.from)
      ? context.read<ConverterScreenBloc>().state.fromCurrencyChoosen
      : context.read<ConverterScreenBloc>().state.toCurrencyChoosen;

  return showDialog<void>(
    context: context,
    // barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Choose a currency'),
        content: SingleChildScrollView(
          child: ListBody(
            children: currencies.currencies.entries.map((entry) {
              return RadioListTile<String>(
                title: Text(entry.value),
                value: entry.key,
                groupValue: selectedCurrencyCode,
                onChanged: (value) {
                  context.read<ConverterScreenBloc>().add(SaveChoosenCurrency(shortName: value!, type: type));
                  Navigator.of(dialogContext).pop();
                },
              );
            }).toList(),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              context.read<ConverterScreenBloc>().add(SaveChoosenCurrency(shortName: '', type: type));
              Navigator.of(dialogContext).pop();
            },
          ),
        ],
      );
    },
  );
}
