import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/core/utils/app_constant_strings.dart';
import 'package:tmdb/data/models/results_model.dart';
import 'package:tmdb/data/repositories/popular_people_repository.dart';

part 'people_state.dart';

class PeopleCubit extends Cubit<PeopleStates> {
  final PopularPeopleRepository popularPeopleRepository;

  PeopleCubit({required this.popularPeopleRepository})
      : super(PeopleInitialState());

  static PeopleCubit of(BuildContext context) => BlocProvider.of(context);

  int page = 1;

  Future<void> getPopularPeople() async {
    if (state is PeopleLoadingState) return;

    if (page <= 500) {
      final currentState = state;

      var oldPeople = <ResultsModel>[];

      if (currentState is PeopleLoadedState) {
        oldPeople = currentState.people;
      } else if (currentState is PeopleErrorState) {
        page = 1;
        oldPeople = <ResultsModel>[];
      }

      emit(PeopleLoadingState(oldPeople: oldPeople, isFirstFetch: page == 1));

      Either<Failure, List<ResultsModel>> response =
          await popularPeopleRepository.getPopularPeople(page);

      emit(
        response.fold(
          (failure) => PeopleErrorState(
              message: AppConstants.mapFailureToMessage(failure)),
          (people) {
            page++;
            final peopleList = (state as PeopleLoadingState).oldPeople;
            peopleList.addAll(people);
            return PeopleLoadedState(people: peopleList);
          },
        ),
      );
    } else {
      emit(PeopleErrorState(message: 'No More People'));
    }
  }
}
