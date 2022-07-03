import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/core/errors/exceptions.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/data/models/person_model.dart';

abstract class PeopleLocalDataSource {
  Future<PersonModel> getCachedPeople();
  Future<Unit> cachePeople(PersonModel peopleList);
}

class PeopleLocalDataSourceImpl implements PeopleLocalDataSource {
  final SharedPreferences sharedPreferences;

  PeopleLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<PersonModel> getCachedPeople() {
    final jsonString =
        sharedPreferences.getString(AppStrings.cachedPopularPeople);

    if (jsonString != null) {
      Map<String, dynamic> decodedJsonData = json.decode(jsonString);
      PersonModel jsonToPersonModels = PersonModel.fromJson(decodedJsonData);
      return Future.value(jsonToPersonModels);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<Unit> cachePeople(PersonModel peopleList) {
    Map<String, dynamic> peopleListToJson = peopleList.toJson();

    sharedPreferences.setString(
      AppStrings.cachedPopularPeople,
      json.encode(peopleListToJson),
    );

    return Future.value(unit);
  }
}
