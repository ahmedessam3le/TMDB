import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/app.dart';
import 'package:tmdb/bloc_observer.dart';
import 'package:tmdb/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  BlocOverrides.runZoned(
    () {
      runApp(const TmdbApp());
    },
    blocObserver: AppBlocObserver(),
  );
}
