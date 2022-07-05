import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/data/models/images_model.dart';
import 'package:tmdb/data/repositories/person_images_repository.dart';

class MockPersonImagesRepository extends Mock
    implements PersonImagesRepository {
  MockPersonImagesRepository() {
    throwOnMissingStub(this);
  }

  Future<Either<Failure, List<ImageModel>>> getPersonImages(int personID) =>
      super.noSuchMethod(Invocation.method(#getPersonImages, []),
          returnValue: Future<Either<Failure, List<ImageModel>>>.value(
              Right(<ImageModel>[])));
}
