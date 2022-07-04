import 'package:dartz/dartz.dart';
import 'package:tmdb/core/errors/exceptions.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/core/network/network_info.dart';
import 'package:tmdb/data/data_sources/locale_data_source/people_local_data_source.dart';
import 'package:tmdb/data/data_sources/web_services/people_web_service.dart';
import 'package:tmdb/data/models/results_model.dart';

class PopularPeopleRepository {
  final NetworkInfo networkInfo;
  final PeopleWebService peopleRemoteDataSource;
  final PeopleLocalDataSource peopleLocalDataSource;

  PopularPeopleRepository({
    required this.networkInfo,
    required this.peopleRemoteDataSource,
    required this.peopleLocalDataSource,
  });

  Future<Either<Failure, List<ResultsModel>>> getPopularPeople(int page) async {
    if (page == 1) {
      if (await networkInfo.isConnected()) {
        try {
          final remotePeople = await peopleRemoteDataSource.getPeople(page);
          peopleLocalDataSource.cachePeople(remotePeople.resultsModel!);
          return Right(remotePeople.resultsModel!);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        try {
          final localPeople = await peopleLocalDataSource.getCachedPeople();
          return Right(localPeople);
        } on CacheException {
          return Left(CacheFailure());
        }
      }
    } else {
      if (await networkInfo.isConnected()) {
        try {
          final remotePeople = await peopleRemoteDataSource.getPeople(page);
          List<ResultsModel> oldPeople =
              await peopleLocalDataSource.getCachedPeople();

          oldPeople.addAll(remotePeople.resultsModel!);
          peopleLocalDataSource.cachePeople(oldPeople);
          return Right(remotePeople.resultsModel!);
        } on ServerException {
          return Left(ServerFailure());
        }
      } else {
        return Left(ServerFailure());
      }
    }
  }
}
