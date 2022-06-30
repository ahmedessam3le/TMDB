import 'package:tmdb/features/popular_peoples/domain/entities/person.dart';

class PersonModel extends Person {
  PersonModel({
    required int id,
    required String name,
    required String profile_path,
    required double popularity,
    required bool adult,
    required int gender,
    required String known_for_department,
  }) : super(
          id: id,
          name: name,
          profile_path: profile_path,
          popularity: popularity,
          adult: adult,
          gender: gender,
          known_for_department: known_for_department,
        );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      profile_path: json['profile_path'],
      popularity: json['popularity'],
      adult: json['adult'],
      gender: json['gender'],
      known_for_department: json['known_for_department'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profile_path': profile_path,
      'popularity': popularity,
      'adult': adult,
      'gender': gender,
      'known_for_department': known_for_department,
    };
  }
}
