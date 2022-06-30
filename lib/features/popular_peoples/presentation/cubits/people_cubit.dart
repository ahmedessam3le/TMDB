import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/features/popular_peoples/domain/entities/person.dart';
import 'package:tmdb/features/popular_peoples/domain/use_cases/get_popular_people_use_case.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleStates> {
  final GetPopularPeopleUseCase getPopularPeopleUseCase;

  PeopleCubit({required this.getPopularPeopleUseCase})
      : super(PeopleInitialState());

  int page = 1;

  Future<void> getPopularPeople() async {
    emit(PeopleLoadingState());
    Either<Failure, List<Person>> response =
        await getPopularPeopleUseCase(page);

    response.fold(
      (failure) => PeopleErrorState(message: _mapFailureToMessage(failure)),
      (people) => PeopleLoadedState(people: people),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      default:
        return AppStrings.unExpectedError;
    }
  }
}
