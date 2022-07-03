import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/data/models/person_model.dart';
import 'package:tmdb/data/repositories/popular_people_repository.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleStates> {
  final PopularPeopleRepository popularPeopleRepository;

  PeopleCubit({required this.popularPeopleRepository})
      : super(PeopleInitialState());

  static PeopleCubit of(BuildContext context) => BlocProvider.of(context);

  int page = 1;

  Future<void> getPopularPeople() async {
    emit(PeopleLoadingState());
    Either<Failure, PersonModel> response =
        await popularPeopleRepository.getPopularPeople(page);

    emit(
      response.fold(
        (failure) => PeopleErrorState(message: _mapFailureToMessage(failure)),
        (people) => PeopleLoadedState(people: people),
      ),
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