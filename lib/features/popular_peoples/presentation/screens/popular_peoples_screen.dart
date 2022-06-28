import 'package:flutter/material.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/features/popular_peoples/presentation/widgets/people_item.dart';

class PopularPeoplesScreen extends StatelessWidget {
  PopularPeoplesScreen({Key? key}) : super(key: key);

  Widget buildCharactersList() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 100,
        itemBuilder: (ctx, index) {
          return PeopleItem(
              // character: _searchTextController.text.isEmpty
              //     ? allCharacters[index]
              //     : searchedCharacters[index],
              );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appName),
      ),
      body: buildCharactersList(),
    );
  }
}
