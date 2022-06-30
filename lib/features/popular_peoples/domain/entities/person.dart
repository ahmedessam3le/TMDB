import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final int id;
  final String name;
  final String profile_path;
  final double popularity;
  final bool adult;
  final int gender;
  final String known_for_department;

  Person({
    required this.id,
    required this.name,
    required this.profile_path,
    required this.popularity,
    required this.adult,
    required this.gender,
    required this.known_for_department,
  });

  @override
  List<Object?> get props => [id];
}
