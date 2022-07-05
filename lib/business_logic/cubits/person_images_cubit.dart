import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/core/utils/app_constanttrings.dart';
import 'package:tmdb/data/models/images_model.dart';
import 'package:tmdb/data/repositories/person_images_repository.dart';

part 'person_images_state.dart';

class PersonImagesCubit extends Cubit<PersonImagesStates> {
  final PersonImagesRepository personImagesRepository;
  PersonImagesCubit({required this.personImagesRepository})
      : super(PersonImagesInitialState());

  void getPersonImages(int personId) async {
    Either<Failure, List<ImageModel>> response =
        await personImagesRepository.getPersonImages(personId);

    emit(
      response.fold(
          (failure) =>
              PersonImagesErrorState(AppConstants.mapFailureToMessage(failure)),
          (images) => PersonImagesLoadedState(images)),
    );
  }
}
