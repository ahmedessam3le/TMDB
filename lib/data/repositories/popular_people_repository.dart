import 'package:dartz/dartz.dart';
import 'package:tmdb/core/errors/exceptions.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/core/network/network_info.dart';
import 'package:tmdb/data/data_sources/people_local_data_source.dart';
import 'package:tmdb/data/data_sources/people_remote_data_source.dart';
import 'package:tmdb/data/models/person_model.dart';

class PopularPeopleRepository {
  final NetworkInfo networkInfo;
  final PeopleRemoteDataSource peopleRemoteDataSource;
  final PeopleLocalDataSource peopleLocalDataSource;

  PopularPeopleRepository({
    required this.networkInfo,
    required this.peopleRemoteDataSource,
    required this.peopleLocalDataSource,
  });
  Future<Either<Failure, PersonModel>> getPopularPeople(
    int page,
    // bool isFirst,
  ) async {
    if (await networkInfo.isConnected()) {
      try {
        final remotePeople = await peopleRemoteDataSource.getPeople(page);
        peopleLocalDataSource.cachePeople(remotePeople);
        return Right(remotePeople);
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
  }
}
