import 'package:currency_conversion/presentation/pages/converter_screen/bloc/converter_screen_bloc.dart';
import 'package:currency_conversion/presentation/pages/converter_screen/bloc/converter_screen_event.dart';
import 'package:currency_conversion/presentation/pages/converter_screen/bloc/converter_screen_state.dart';
import 'package:currency_conversion/presentation/widgets/currencies_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrencyConverterPage extends StatefulWidget {
  const CurrencyConverterPage({super.key});

  @override
  State<CurrencyConverterPage> createState() => _CurrencyConverterPageState();
}

class _CurrencyConverterPageState extends State<CurrencyConverterPage> {
  final TextEditingController _toAmountController = TextEditingController();
  final TextEditingController _fromAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fromAmountController.dispose();
    _toAmountController.dispose();
    super.dispose();
  }

  /// TODO using bloc news is better
  void showErrorSnackbar(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      const snackbar = SnackBar(
        content: Text('Something went wrong'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text('Currency converter', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
        centerTitle: false,
      ),
      body: BlocListener<ConverterScreenBloc, ConverterScreenState>(listener: (context, state) {
        if (state.isError) {
          const snackbar = SnackBar(
            content: Text('Something went wrong'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }, child: BlocBuilder<ConverterScreenBloc, ConverterScreenState>(builder: (context, state) {
        _toAmountController.text = state.toAmmount?.toString() ?? '';

        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ConverterScreenBloc>().add(OnRefresh());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0, bottom: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'You send',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: TextField(
                          controller: _fromAmountController,
                          decoration: const InputDecoration(
                              // hintText: 'Enter amount',
                              ),
                          keyboardType: TextInputType.number,
                        )),
                        const SizedBox(width: 50),
                        if (state.fromCurrencyChoosen != '')
                          Text(
                            state.fromCurrencyChoosen,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        if (state.currenciesEntity != null)
                          IconButton(
                            onPressed: () {
                              showCurrencySelectionDialog(context, state.currenciesEntity!, AdressType.from);
                            },
                            icon: const Icon(
                              Icons.arrow_downward_sharp,
                              size: 24.0,
                            ),
                          )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Expanded(
                            child: IconButton(
                              onPressed: () {
                                context.read<ConverterScreenBloc>().add(OnChangeFromTo());
                              },
                              icon: const Icon(
                                Icons.swap_vert,
                                size: 24.0,
                              ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                    const Text(
                      'They get',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            readOnly: true,
                            controller: _toAmountController,
                            decoration: const InputDecoration(
                                // hintText: 'Enter amount',
                                ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        const SizedBox(width: 50),
                        if (state.toCurrencyChoosen != '')
                          Text(
                            state.toCurrencyChoosen,
                            style: const TextStyle(fontSize: 18.0),
                          ),
                        if (state.currenciesEntity != null)
                          IconButton(
                            onPressed: () {
                              showCurrencySelectionDialog(context, state.currenciesEntity!, AdressType.to);
                            },
                            icon: const Icon(
                              Icons.arrow_downward_sharp,
                              size: 24.0,
                            ),
                          )
                      ],
                    ),
                    const SizedBox(height: 200),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          double? amount = double.tryParse(_fromAmountController.value.text);
                          if (amount != null) {
                            context.read<ConverterScreenBloc>().add(CountRate(ammount: amount));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: const TextStyle(fontSize: 20),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: Text('Convert', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      })),
    );
  }
}
