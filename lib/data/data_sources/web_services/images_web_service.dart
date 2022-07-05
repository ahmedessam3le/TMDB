import 'package:tmdb/core/api/api_consumer.dart';
import 'package:tmdb/core/api/end_points.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/data/models/person_images_model.dart';

abstract class ImagesWebService {
  Future<PersonImagesModel> getImages(int personId);
}

class ImagesWebServiceImpl implements ImagesWebService {
  ApiConsumer apiConsumer;

  ImagesWebServiceImpl({required this.apiConsumer});
  @override
  Future<PersonImagesModel> getImages(int personId) async {
    final response = await apiConsumer
        .get(EndPoints.baseUrl + '$personId/images', queryParameters: {
      AppStrings.apiKey_KEY: AppStrings.apiKey_VALUE,
      AppStrings.language: AppStrings.languageValue,
    });

    final PersonImagesModel personImagesModels =
        PersonImagesModel.fromJson(response);

    return personImagesModels;
  }
}
