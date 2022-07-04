import 'package:tmdb/core/api/api_consumer.dart';
import 'package:tmdb/core/api/end_points.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/data/models/person_model.dart';

abstract class PeopleWebService {
  Future<PersonModel> getPeople(int page);
}

class PeopleWebServiceImpl implements PeopleWebService {
  ApiConsumer apiConsumer;

  PeopleWebServiceImpl({required this.apiConsumer});
  @override
  Future<PersonModel> getPeople(int page) async {
    final response =
        await apiConsumer.get(EndPoints.popularPeople, queryParameters: {
      AppStrings.apiKey_KEY: AppStrings.apiKey_VALUE,
      AppStrings.language: AppStrings.languageValue,
      AppStrings.page: page,
    });

    final PersonModel personModels = PersonModel.fromJson(response);

    return personModels;
  }
}
