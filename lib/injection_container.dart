import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/core/api/api_consumer.dart';
import 'package:tmdb/core/api/app_interceptors.dart';
import 'package:tmdb/core/api/dio_consumer.dart';
import 'package:tmdb/core/network/network_info.dart';
import 'package:tmdb/features/popular_peoples/data/data_sources/people_local_data_source.dart';
import 'package:tmdb/features/popular_peoples/data/data_sources/people_remote_data_source.dart';
import 'package:tmdb/features/popular_peoples/data/repositories/popular_people_repository_impl.dart';
import 'package:tmdb/features/popular_peoples/domain/repositories/popular_people_repository.dart';
import 'package:tmdb/features/popular_peoples/domain/use_cases/get_popular_people_use_case.dart';
import 'package:tmdb/features/popular_peoples/presentation/cubits/people_cubit.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  // 1 - Features
  // a) Blocs

  serviceLocator.registerFactory<PeopleCubit>(
    () => PeopleCubit(
      getPopularPeopleUseCase: serviceLocator(),
    ),
  );

  // b) Use Cases

  serviceLocator.registerLazySingleton<GetPopularPeopleUseCase>(
    () => GetPopularPeopleUseCase(
      peopleRepository: serviceLocator(),
    ),
  );

  // c) Repositories

  serviceLocator.registerLazySingleton<PopularPeopleRepository>(
    () => PopularPeopleRepositoryImpl(
      networkInfo: serviceLocator(),
      peopleRemoteDataSource: serviceLocator(),
      peopleLocalDataSource: serviceLocator(),
    ),
  );

  // d) Data Sources

  serviceLocator.registerLazySingleton<PeopleRemoteDataSource>(
    () => PeopleRemoteDataSourceImpl(
      apiConsumer: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<PeopleLocalDataSource>(
    () => PeopleLocalDataSourceImpl(
      sharedPreferences: serviceLocator(),
    ),
  );

  // 2 - Core

  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
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
