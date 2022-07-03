import 'package:tmdb/data/models/results_model.dart';

class PersonModel {
  PersonModel({
    this.page,
    this.resultsModel,
    this.totalPages,
    this.totalResults,
  });

  PersonModel.fromJson(dynamic json) {
    page = json['page'];
    if (json['results'] != null) {
      resultsModel = [];
      json['results'].forEach((v) {
        resultsModel?.add(ResultsModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }
  int? page;
  List<ResultsModel>? resultsModel;
  int? totalPages;
  int? totalResults;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    if (resultsModel != null) {
      map['results'] = resultsModel?.map((v) => v.toJson()).toList();
    }
    map['total_pages'] = totalPages;
    map['total_results'] = totalResults;
    return map;
  }
}
