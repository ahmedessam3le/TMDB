import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdb/business_logic/cubits/person_images_cubit.dart';
import 'package:tmdb/core/utils/app_colors.dart';
import 'package:tmdb/core/utils/app_constants.dart';
import 'package:tmdb/core/utils/app_responsive.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/data/models/images_model.dart';
import 'package:tmdb/data/models/results_model.dart';
import 'package:tmdb/presentation/widgets/image_item.dart';

import '../../core/api/end_points.dart';
import '../../core/utils/assets_manager.dart';

class PersonDetailsScreen extends StatelessWidget {
  final ResultsModel person;
  const PersonDetailsScreen({Key? key, required this.person}) : super(key: key);

  Widget buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
        onPressed: () => Navigator.of(context).pop(),
      ),
      expandedHeight: 500.hp,
      pinned: true,
      stretch: true,
      backgroundColor: AppColors.scaffoldBackgroundColor,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Hero(
          tag: person.id!,
          child: person.profilePath != null
              ? CachedNetworkImage(
                  placeholder: (context, index) =>
                      Image.asset(ImageAssets.loadingIMG),
                  imageUrl: EndPoints.imageUrl + person.profilePath!,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  ImageAssets.placeHolderIMG,
                  fit: BoxFit.cover,
                ),
        ),
        title: Container(
          color: Colors.black54,
          child: Text(
            person.name!,
            style: TextStyle(color: AppColors.hintColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget buildCharacterInfo({required String title, required String value}) {
    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: AppColors.primaryColor,
              backgroundColor: Colors.black54,
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              height: 2,
            ),
          ),
          TextSpan(
            text: title == 'Gender :'
                ? int.parse(value) == 1
                    ? ' Female'
                    : ' Male'
                : value,
            style: TextStyle(
              color: AppColors.hintColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget checkIfImagesLoaded(BuildContext context, PersonImagesStates state) {
    if (state is PersonImagesLoadedState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.images,
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 30.hp),
          displayImages(state),
        ],
      );
    } else {
      return AppConstants.showLoadingIndicator();
    }
  }

  Widget displayImages(state) {
    List<ImageModel>? images = state.images;
    if (images!.isNotEmpty) {
      return Center(
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
          itemCount: images.length,
          itemBuilder: (ctx, index) {
            return ImageItem(imageModel: images[index]);
          },
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PersonImagesCubit>(context).getPersonImages(person.id!);

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(context),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14.wp, 14.hp, 14.wp, 0.hp),
                  // padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCharacterInfo(
                        title: AppStrings.popularity,
                        value: '  ' + person.popularity!.toStringAsFixed(1),
                      ),
                      buildCharacterInfo(
                        title: AppStrings.job,
                        value: ' ' + person.knownForDepartment!,
                      ),
                      buildCharacterInfo(
                        title: AppStrings.gender,
                        value: ' ' + person.gender.toString(),
                      ),
                      SizedBox(height: 50.hp),
                      BlocBuilder<PersonImagesCubit, PersonImagesStates>(
                        builder: (context, state) {
                          return checkIfImagesLoaded(context, state);
                        },
                      ),
                    ],
                  ),
                ),
                // SizedBox(height: 250),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
