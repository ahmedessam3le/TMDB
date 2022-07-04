part of 'people_cubit.dart';

abstract class PeopleStates extends Equatable {
  const PeopleStates();

  @override
  List<Object?> get props => [];
}

class PeopleInitialState extends PeopleStates {}

class PeopleLoadingState extends PeopleStates {
  final List<ResultsModel> oldPeople;
  final bool isFirstFetch;

  PeopleLoadingState({required this.oldPeople, this.isFirstFetch = false});

  @override
  List<Object?> get props => [oldPeople];
}

class PeopleLoadedState extends PeopleStates {
  final List<ResultsModel> people;

  PeopleLoadedState({required this.people});

  @override
  List<Object?> get props => [people];
}

class PeopleErrorState extends PeopleStates {
  final String message;

  PeopleErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
