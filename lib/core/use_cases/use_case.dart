import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tmdb/core/errors/failure.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object?> get props => [];
}

class PeopleParams extends Equatable {
  final int page;
  // final bool isFirst;

  PeopleParams({required this.page});
  @override
  List<Object?> get props => [page];
}
