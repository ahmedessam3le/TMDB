import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tmdb/core/errors/exceptions.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/data/models/results_model.dart';

abstract class PeopleLocalDataSource {
  Future<List<ResultsModel>> getCachedPeople();
  Future<Unit> cachePeople(List<ResultsModel> peopleList);
}

class PeopleLocalDataSourceImpl implements PeopleLocalDataSource {
  final SharedPreferences sharedPreferences;

  PeopleLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<List<ResultsModel>> getCachedPeople() {
    final jsonString =
        sharedPreferences.getString(AppStrings.cachedPopularPeople);

    if (jsonString != null) {
      List decodedJsonData = json.decode(jsonString);
      List<ResultsModel> jsonToPersonModels = decodedJsonData
          .map<ResultsModel>(
              (jsonPersonModel) => ResultsModel.fromJson(jsonPersonModel))
          .toList();
      return Future.value(jsonToPersonModels);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<Unit> cachePeople(List<ResultsModel> peopleList) async {
    List peopleListToJson = peopleList
        .map<Map<String, dynamic>>((peopleModel) => peopleModel.toJson())
        .toList();

    sharedPreferences.setString(
      AppStrings.cachedPopularPeople,
      json.encode(peopleListToJson),
    );

    debugPrint('PEOPLE LIST CACHED SUCCESSFULLY');

    return Future.value(unit);
  }
}
