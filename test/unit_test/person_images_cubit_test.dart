import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/business_logic/cubits/person_images_cubit.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/data/models/images_model.dart';
import 'package:tmdb/data/repositories/person_images_repository.dart';

import 'person_cubit_test_mocks.dart';

@GenerateMocks([PersonImagesRepository])
void main() {
  late PersonImagesCubit personImagesCubit;
  late PersonImagesRepository mockPersonImagesRepository;

  setUp(() {
    mockPersonImagesRepository = MockPersonImagesRepository();
    personImagesCubit =
        PersonImagesCubit(personImagesRepository: mockPersonImagesRepository);
  });

  test(
    'PersonImagesCubit should emit PersonImagesLoadingState then PersonImagesLoadedState State with a list of person images when calling getPersonImages method',
    () {
      final personId = 86654;
      final images = [
        ImageModel(
          aspectRatio: 0.667,
          height: 2785,
          iso6391: null,
          filePath: "/2gHiYPXOq7RJLs4vTz5fUmSg8cd.jpg",
          voteAverage: 5.206,
          voteCount: 9,
          width: 1857,
        ),
        ImageModel(
          aspectRatio: 0.667,
          height: 712,
          iso6391: null,
          filePath: "/tmU9jtSs6c4ySC5eiad3aXXADan.jpg",
          voteAverage: 5.146,
          voteCount: 10,
          width: 475,
        ),
        ImageModel(
          aspectRatio: 0.667,
          height: 967,
          iso6391: null,
          filePath: "/3nFpFd3Rt5pa9xkbF7MhwzLGbw8.jpg",
          voteAverage: 5.128,
          voteCount: 6,
          width: 645,
        ),
      ];

      when(mockPersonImagesRepository.getPersonImages(personId))
          .thenAnswer((_) => Future.value(Right(images)));

      final expectedStates = [
        PersonImagesLoadingState(),
        PersonImagesLoadedState(images),
      ];

      expectLater(personImagesCubit.stream, emitsInAnyOrder(expectedStates));

      personImagesCubit.getPersonImages(personId);
    },
  );

  test(
    'PersonImagesCubit should emit PersonImagesLoadingState then PersonImagesErrorState State when calling getPersonImages method if repository throw an exception',
    () {
      final personId = 86654;
      final images = [
        ImageModel(
          aspectRatio: 0.667,
          height: 2785,
          iso6391: null,
          filePath: "/2gHiYPXOq7RJLs4vTz5fUmSg8cd.jpg",
          voteAverage: 5.206,
          voteCount: 9,
          width: 1857,
        ),
        ImageModel(
          aspectRatio: 0.667,
          height: 712,
          iso6391: null,
          filePath: "/tmU9jtSs6c4ySC5eiad3aXXADan.jpg",
          voteAverage: 5.146,
          voteCount: 10,
          width: 475,
        ),
        ImageModel(
          aspectRatio: 0.667,
          height: 967,
          iso6391: null,
          filePath: "/3nFpFd3Rt5pa9xkbF7MhwzLGbw8.jpg",
          voteAverage: 5.128,
          voteCount: 6,
          width: 645,
        ),
      ];

      when(mockPersonImagesRepository.getPersonImages(personId))
          .thenAnswer((_) => Future.value(Left(ServerFailure())));

      final expectedStates = [
        PersonImagesLoadingState(),
        PersonImagesErrorState('Internet Connection Error'),
      ];

      expectLater(personImagesCubit.stream, emitsInAnyOrder(expectedStates));

      personImagesCubit.getPersonImages(personId);
    },
  );
}
