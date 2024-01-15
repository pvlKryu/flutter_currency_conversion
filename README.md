# flutter_currency_conversion
Test task for developing a simple application for currency conversion

## Task: 
It is required to develop an application that allows the conversion of a certain amount from one currency selected by the user into another currency also selected by the user based on the proposed screen forms.

## Expected functionality: 
The application should communicate with any open API of the trading platform that allows you to receive information about exchange rates, for example, you can use https://exchangeratesapi.io/. It is proposed to implement communication with the application’s network logic using the Dio package, but the developer can use any other library that is convenient for him. The application must also store data locally to be able to work without access to the Internet. In the absence of a network, the application must take data from local storage and update this data in local storage when a network appears. It is proposed to implement work with local application storage using the Isar package, but the developer can use any other library convenient for him.

## Result: 
An application was developed that fully complies with the requirements and has the requested functionality.

This application is built on the principle of clean architecture and is divided into layers: data, domain, di, presentation. Web - Dio, State managment - bloc. DI - GetIt(). Local DB - Isar. 

Error handling and error pop-up notification are provided

## Stack used: 
Dart + Flutter, DIO + Retrofit, json_annotation, bloc + flutter_bloc, equatable, connectivity, isar, getIt, path_provider.

![Simulator Screenshot - iPhone 14 Pro - 2024-01-15 at 15 11 54](https://github.com/pvlKryu/flutter_currency_conversion/assets/57821178/55797796-d058-4c7e-8cfd-f80ffb580bd0)


