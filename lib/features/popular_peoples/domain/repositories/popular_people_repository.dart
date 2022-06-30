import 'package:dartz/dartz.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/features/popular_peoples/domain/entities/person.dart';

abstract class PopularPeopleRepository {
  Future<Either<Failure, List<Person>>> getPopularPeople(
    int page,
    // bool isFirst,
  );
}
