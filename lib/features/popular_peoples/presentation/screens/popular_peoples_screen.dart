import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb/core/utils/app_colors.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/core/widgets/app_error_widget.dart';
import 'package:tmdb/features/popular_peoples/domain/entities/person.dart';
import 'package:tmdb/features/popular_peoples/presentation/cubits/people_cubit.dart';
import 'package:tmdb/features/popular_peoples/presentation/widgets/person_item.dart';

class PopularPeoplesScreen extends StatefulWidget {
  PopularPeoplesScreen({Key? key}) : super(key: key);

  @override
  State<PopularPeoplesScreen> createState() => _PopularPeoplesScreenState();
}

class _PopularPeoplesScreenState extends State<PopularPeoplesScreen> {
  _getPopularPeople() {
    BlocProvider.of<PeopleCubit>(context).getPopularPeople();
  }

  @override
  void initState() {
    super.initState();

    // _getPopularPeople();
  }

  Widget buildCharactersList({required List<Person> people}) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: people.length,
        itemBuilder: (ctx, index) {
          return PersonItem(
            person: people[index],
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
    final appBar = AppBar(
      title: Text(AppStrings.appName),
    );
    return BlocBuilder<PeopleCubit, PeopleStates>(
      builder: (context, state) {
        if (state is PeopleLoadingState) {
          return Scaffold(
            appBar: appBar,
            body: Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
              ),
            ),
          );
        } else if (state is PeopleErrorState) {
          return Scaffold(
            appBar: appBar,
            body: AppErrorWidget(
              message: state.message,
              onPress: _getPopularPeople(),
            ),
          );
        } else if (state is PeopleLoadedState) {
          return Scaffold(
            appBar: appBar,
            body: buildCharactersList(people: state.people),
          );
        } else {
          return Scaffold(
            appBar: appBar,
            body: Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
              ),
            ),
          );
        }
      },
    );
  }
}
