import 'package:flutter/material.dart';
import 'package:tmdb/config/routes/app_routes.dart';
import 'package:tmdb/config/themes/app_theme.dart';
import 'package:tmdb/core/utils/app_strings.dart';

class TmdbApp extends StatelessWidget {
  const TmdbApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MultiBlocProvider(
    //   providers: [
    //     // BlocProvider(
    //     //   create: (context) =>
    //     //       di.serviceLocator<LocaleCubit>()..getSavedLanguage(),
    //     // ),
    //   ],
    //   child: MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     title: AppStrings.appName,
    //     theme: appTheme(),
    //     onGenerateRoute: AppRoutes.onGenerateRoute,
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: appTheme(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}