import 'package:dartz/dartz.dart';
import 'package:tmdb/core/errors/exceptions.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/core/network/network_info.dart';
import 'package:tmdb/features/popular_peoples/data/data_sources/people_local_data_source.dart';
import 'package:tmdb/features/popular_peoples/data/data_sources/people_remote_data_source.dart';
import 'package:tmdb/features/popular_peoples/data/models/person_model.dart';
import 'package:tmdb/features/popular_peoples/domain/repositories/popular_people_repository.dart';

class PopularPeopleRepositoryImpl implements PopularPeopleRepository {
  final NetworkInfo networkInfo;
  final PeopleRemoteDataSource peopleRemoteDataSource;
  final PeopleLocalDataSource peopleLocalDataSource;

  PopularPeopleRepositoryImpl({
    required this.networkInfo,
    required this.peopleRemoteDataSource,
    required this.peopleLocalDataSource,
  });
  @override
  Future<Either<Failure, List<PersonModel>>> getPopularPeople(
    int page,
    // bool isFirst,
  ) async {
    if (await networkInfo.isConnected()) {
      try {
        final remotePeople = await peopleRemoteDataSource.getPeople(page);
        peopleLocalDataSource.cachePeople(remotePeople);
        return Right(remotePeople);

        // peopleLocalDataSource.cachePeople(remotePeople
        //     .map((person) => PersonModel.fromJson(person))
        //     .toList());

        // return Right(remotePeople
        //     .map((person) => PersonModel.fromJson(person))
        //     .toList());
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
