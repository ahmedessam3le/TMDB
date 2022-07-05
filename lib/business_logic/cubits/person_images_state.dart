part of 'person_images_cubit.dart';

abstract class PersonImagesStates extends Equatable {
  const PersonImagesStates();

  @override
  List<Object?> get props => [];
}

class PersonImagesInitialState extends PersonImagesStates {}

class PersonImagesLoadingState extends PersonImagesStates {}

class PersonImagesLoadedState extends PersonImagesStates {
  final List<ImageModel> images;

  PersonImagesLoadedState(this.images);

  @override
  List<Object?> get props => [images];
}

class PersonImagesErrorState extends PersonImagesStates {
  final String message;

  PersonImagesErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
