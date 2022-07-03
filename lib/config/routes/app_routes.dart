import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/business_logic/cubits/people_cubit.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/injection_container.dart' as di;
import 'package:tmdb/presentation/screens/popular_peoples_screen.dart';
import 'package:tmdb/presentation/screens/splash_screen.dart';

class Routes {
  static const String initialRoute = '/';
  static const String popularPeoples = '/popularPeoples';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.popularPeoples:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) =>
                di.serviceLocator<PeopleCubit>()..getPopularPeople(),
            child: PopularPeoplesScreen(),
          ),
        );

      case Routes.initialRoute:
        return MaterialPageRoute(
          builder: (context) => SplashScreen(),
        );

      // case Routes.randomQuoteRoute:
      //   return MaterialPageRoute(
      //     builder: (context) => BlocProvider(
      //       create: (context) {
      //         return di.serviceLocator<RandomQuoteCubit>();
      //       },
      //       child: QuoteScreen(),
      //     ),
      //   );

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
