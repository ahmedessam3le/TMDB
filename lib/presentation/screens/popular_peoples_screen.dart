import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/business_logic/cubits/people_cubit.dart';
import 'package:tmdb/core/utils/app_constants.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/core/widgets/app_error_widget.dart';
import 'package:tmdb/data/models/person_model.dart';
import 'package:tmdb/presentation/widgets/person_item.dart';

class PopularPeoplesScreen extends StatelessWidget {
  PopularPeoplesScreen({Key? key}) : super(key: key);

  Widget buildCharactersList({required PersonModel people}) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: people.resultsModel!.length,
        itemBuilder: (ctx, index) {
          return PersonItem(
            person: people.resultsModel![index],
          );
        },
      ),
    );
  }

  PersonModel? people;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PeopleCubit, PeopleStates>(
      listener: (context, state) {
        if (state is PeopleLoadedState) {
          people = state.people;
        }
      },
      builder: (context, state) {
        var cubit = PeopleCubit.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.appName),
          ),
          body: state is PeopleErrorState
              ? AppErrorWidget(
                  message: state.message,
                  onPress: () => cubit.getPopularPeople(),
                )
              : ConditionalBuilder(
                  condition: state is! PeopleLoadingState && people != null,
                  builder: (context) => buildCharactersList(people: people!),
                  fallback: (context) => AppConstants.showLoadingIndicator(),
                ),
        );
      },
    );
  }
}
