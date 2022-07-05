import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/business_logic/cubits/people_cubit.dart';
import 'package:tmdb/business_logic/cubits/person_images_cubit.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/data/models/images_model.dart';
import 'package:tmdb/data/models/results_model.dart';
import 'package:tmdb/injection_container.dart' as di;
import 'package:tmdb/presentation/screens/image_preview_screen.dart';
import 'package:tmdb/presentation/screens/person_details_screen.dart';
import 'package:tmdb/presentation/screens/popular_peoples_screen.dart';
import 'package:tmdb/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String popularPeoples = '/popularPeoples';
  static const String personDetails = '/personDetails';
  static const String imagePreview = '/imagePreview';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      case Routes.popularPeoples:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                di.serviceLocator<PeopleCubit>()..getPopularPeople(),
            child: PopularPeoplesScreen(),
          ),
        );

      case Routes.personDetails:
        final person = routeSettings.arguments as ResultsModel;
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => di.serviceLocator<PersonImagesCubit>(),
            child: PersonDetailsScreen(person: person),
          ),
        );

      case Routes.imagePreview:
        final image = routeSettings.arguments as ImageModel;
        return MaterialPageRoute(
          builder: (context) => ImagePreviewScreen(imageModel: image),
        );

      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        body: Center(
          child: Text(AppStrings.noRouteFound),
        ),
      ),
    );
  }
}
