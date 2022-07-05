import 'package:dartz/dartz.dart';
import 'package:tmdb/core/errors/exceptions.dart';
import 'package:tmdb/core/errors/failure.dart';
import 'package:tmdb/core/network/network_info.dart';
import 'package:tmdb/data/data_sources/web_services/images_web_service.dart';
import 'package:tmdb/data/models/images_model.dart';

class PersonImagesRepository {
  final NetworkInfo networkInfo;
  final ImagesWebService imagesWebService;

  PersonImagesRepository({
    required this.networkInfo,
    required this.imagesWebService,
  });

  Future<Either<Failure, List<ImageModel>>> getPersonImages(
      int personId) async {
    if (await networkInfo.isConnected()) {
      try {
        final personImages = await imagesWebService.getImages(personId);
        return Right(personImages.imagesModel!);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }
}
