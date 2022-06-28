import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/core/api/api_consumer.dart';
import 'package:tmdb/core/api/app_interceptors.dart';
import 'package:tmdb/core/api/dio_consumer.dart';
import 'package:tmdb/core/network/network_info.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // 1 - Features
  // a) Blocs

  // b) Use Cases

  // c) Repositories

  // d) Data Sources

  // 2 - Core

  serviceLocator.registerLazySingleton<NetworkInfoContract>(
    () => NetworkInfo(
      connectionChecker: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<ApiConsumer>(
      () => DioConsumer(client: serviceLocator()));

  // 3 - External

  final sharedPreferences = await SharedPreferences.getInstance();
  serviceLocator.registerLazySingleton(() => sharedPreferences);
  serviceLocator.registerLazySingleton(() => Dio());
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
  serviceLocator.registerLazySingleton(() => AppInterceptors());
  serviceLocator.registerLazySingleton(() => LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ));
}
