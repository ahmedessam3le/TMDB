import 'package:tmdb/data/models/known_for_model.dart';

class ResultsModel {
  ResultsModel({
    this.adult,
    this.gender,
    this.id,
    this.knownFor,
    this.knownForDepartment,
    this.name,
    this.popularity,
    this.profilePath,
  });

  ResultsModel.fromJson(dynamic json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'];
    if (json['known_for'] != null) {
      knownFor = [];
      json['known_for'].forEach((v) {
        knownFor?.add(KnownForModel.fromJson(v));
      });
    }
    knownForDepartment = json['known_for_department'];
    name = json['name'];
    popularity = json['popularity'];
    profilePath = json['profile_path'];
  }
  bool? adult;
  int? gender;
  int? id;
  List<KnownForModel>? knownFor;
  String? knownForDepartment;
  String? name;
  double? popularity;
  String? profilePath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['adult'] = adult;
    map['gender'] = gender;
    map['id'] = id;
    if (knownFor != null) {
      map['known_for'] = knownFor?.map((v) => v.toJson()).toList();
    }
    map['known_for_department'] = knownForDepartment;
    map['name'] = name;
    map['popularity'] = popularity;
    map['profile_path'] = profilePath;
    return map;
  }
}
