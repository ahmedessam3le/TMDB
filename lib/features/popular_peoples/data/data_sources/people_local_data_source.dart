import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/core/errors/exceptions.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/features/popular_peoples/data/models/person_model.dart';

abstract class PeopleLocalDataSource {
  Future<List<PersonModel>> getCachedPeople();
  Future<Unit> cachePeople(List<PersonModel> peopleList);
}

class PeopleLocalDataSourceImpl implements PeopleLocalDataSource {
  final SharedPreferences sharedPreferences;

  PeopleLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<PersonModel>> getCachedPeople() {
    final jsonString =
        sharedPreferences.getString(AppStrings.cachedPopularPeople);

    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<PersonModel> jsonToPersonModels = decodedJsonData
          .map<PersonModel>(
              (jsonPersonModel) => PersonModel.fromJson(jsonPersonModel))
          .toList();
      return Future.value(jsonToPersonModels);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<Unit> cachePeople(List<PersonModel> peopleList) {
    List peopleListToJson = peopleList
        .map<Map<String, dynamic>>((personModel) => personModel.toJson())
        .toList();

    sharedPreferences.setString(
      AppStrings.cachedPopularPeople,
      json.encode(peopleListToJson),
    );

    return Future.value(unit);
  }
}
