import 'package:dartz/dartz.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/core/use_cases/use_case.dart';
import 'package:tmdb/features/popular_peoples/domain/entities/person.dart';
import 'package:tmdb/features/popular_peoples/domain/repositories/popular_people_repository.dart';

class GetPopularPeopleUseCase implements UseCase<List<Person>, int> {
  final PopularPeopleRepository peopleRepository;

  GetPopularPeopleUseCase({required this.peopleRepository});
  @override
  Future<Either<Failure, List<Person>>> call(int page) async {
    return await peopleRepository.getPopularPeople(
      page,
      // PeopleParams.isFirst,
    );
  }
}
