import 'package:currency_conversion/data/data_sources/locale_data_source.dart';
import 'package:currency_conversion/data/data_sources/remote_data_source.dart';
import 'package:currency_conversion/data/network/api.dart';
import 'package:currency_conversion/data/repository/repository_impl.dart';
import 'package:currency_conversion/domain/repository/repository.dart';
import 'package:currency_conversion/domain/use_cases/get_availible_currencies.dart';
import 'package:currency_conversion/domain/use_cases/get_current_rate.dart';
import 'package:currency_conversion/domain/use_cases/get_current_rate_base.dart';
import 'package:currency_conversion/presentation/pages/converter_screen/bloc/converter_screen_bloc.dart';
import 'package:currency_conversion/presentation/pages/converter_screen/converter_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';

class BaseDi {
  final GetIt getIt = GetIt.instance;
  final dio = Dio();

  void setUp(Isar isarInstance) {
    getIt.registerLazySingleton<Api>(() => Api(dio));
    getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(api: getIt.get()));
    getIt.registerLazySingleton<Isar>(() => isarInstance);
    getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(isar: getIt.get<Isar>()));

    getIt.registerLazySingleton<Repository>(
        () => RepositoryImpl(remoteDataSource: getIt.get(), localDataSourse: getIt.get()));
    getIt.registerFactory<GetAvailibleCurrenciesUseCase>(() => GetAvailibleCurrenciesUseCase(repository: getIt.get()));
    getIt.registerFactory<GetCurrentRateUseCase>(() => GetCurrentRateUseCase(repository: getIt.get()));
    getIt.registerFactory<GetCurrentRateBaseUseCase>(() => GetCurrentRateBaseUseCase(repository: getIt.get()));
  }
}

class ConverterScreen extends StatelessWidget {
  const ConverterScreen({super.key});
  GetIt get getIt => GetIt.I;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConverterScreenBloc>(
      create: (_) => ConverterScreenBloc(
        getAvailibleCurrenciesUseCase: getIt(),
        getCurrentRateBaseUseCase: getIt(),
      ),
      child: const CurrencyConverterPage(),
    );
  }
}
