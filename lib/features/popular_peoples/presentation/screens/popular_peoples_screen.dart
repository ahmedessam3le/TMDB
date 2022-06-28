import 'package:flutter/material.dart';
import 'package:tmdb/core/utils/app_strings.dart';

class PopularPeoplesScreen extends StatelessWidget {
  const PopularPeoplesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
      ),
      body: Center(
        child: Text(
          'Popular Peoples',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
    );
  }
}
