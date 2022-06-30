import 'package:flutter/material.dart';
import 'package:tmdb/core/api/api_consumer.dart';
import 'package:tmdb/core/api/end_points.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/features/popular_peoples/data/models/person_model.dart';

abstract class PeopleRemoteDataSource {
  Future<List<PersonModel>> getPeople(int page);
}

class PeopleRemoteDataSourceImpl implements PeopleRemoteDataSource {
  ApiConsumer apiConsumer;

  PeopleRemoteDataSourceImpl({required this.apiConsumer});
  @override
  Future<List<PersonModel>> getPeople(int page) async {
    final response =
        await apiConsumer.get(EndPoints.popularPeople, queryParameters: {
      AppStrings.apiKey_KEY: AppStrings.apiKey_VALUE,
      AppStrings.language: AppStrings.languageValue,
      AppStrings.page: page,
    });

    final results = response['results'] as List;

    final List<PersonModel> personModels = results
        .map<PersonModel>((postModel) => PersonModel.fromJson(postModel))
        .toList();

    debugPrint('PEOPLE LIST LENGTH : ${personModels.length}');

    return personModels;
  }
}
