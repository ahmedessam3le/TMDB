part of 'people_cubit.dart';

abstract class PeopleStates extends Equatable {
  const PeopleStates();

  @override
  List<Object?> get props => [];
}

class PeopleInitialState extends PeopleStates {}

class PeopleLoadingState extends PeopleStates {}

class PeopleLoadedState extends PeopleStates {
  final PersonModel people;

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
