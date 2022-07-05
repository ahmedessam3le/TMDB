import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/business_logic/cubits/people_cubit.dart';
import 'package:tmdb/core/network/network_info.dart';
import 'package:tmdb/core/utils/app_constants.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/core/widgets/app_error_widget.dart';
import 'package:tmdb/data/models/results_model.dart';
import 'package:tmdb/injection_container.dart';
import 'package:tmdb/presentation/widgets/person_item.dart';

class PopularPeoplesScreen extends StatelessWidget {
  PopularPeoplesScreen({Key? key}) : super(key: key);

  final scrollController = ScrollController();

  void setUpScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          serviceLocator<NetworkInfo>().isConnected().then((value) {
            if (value) {
              BlocProvider.of<PeopleCubit>(context).getPopularPeople();
            } else {
              PeopleCubit.of(context)
                  .emit(PeopleErrorState(message: AppStrings.noMorePeople));
            }
          });
        }
      }
    });
  }

  Widget buildCharactersList({required List<ResultsModel> people}) {
    return SingleChildScrollView(
      controller: scrollController,
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
        itemCount: people.length,
        itemBuilder: (ctx, index) {
          return PersonItem(
            person: people[index],
          );
        },
      ),
    );
  }

  List<ResultsModel>? people = [];

  @override
  Widget build(BuildContext context) {
    setUpScrollController(context);
    return BlocConsumer<PeopleCubit, PeopleStates>(
      listener: (context, state) {
        if (state is PeopleLoadingState) {
          people = state.oldPeople;
        } else if (state is PeopleLoadedState) {
          people = state.people;
        } else if (state is PeopleErrorState && people!.isNotEmpty) {
          AppConstants.showToast(
              message: AppStrings.noMorePeople, toastColor: Colors.red);
        }
      },
      builder: (context, state) {
        var cubit = PeopleCubit.of(context);
        if (state is PeopleLoadingState && state.isFirstFetch) {
          return AppConstants.showLoadingIndicator();
        } else if (state is PeopleErrorState && people!.isEmpty) {
          return AppErrorWidget(
            message: state.message,
            onPress: () => cubit.getPopularPeople(),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(AppStrings.appName),
          ),
          body: buildCharactersList(people: people!),
        );
      },
    );
  }
}
