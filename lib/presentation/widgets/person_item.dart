import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/core/api/end_points.dart';
import 'package:tmdb/core/utils/app_colors.dart';
import 'package:tmdb/core/utils/app_responsive.dart';
import 'package:tmdb/core/utils/assets_manager.dart';
import 'package:tmdb/data/models/results_model.dart';

class PersonItem extends StatelessWidget {
  final ResultsModel person;
  const PersonItem({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.r, horizontal: 8.r),
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.hintColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: InkWell(
        // onTap: () => Navigator.pushNamed(context, characterDetailsScreen,
        //     arguments: character),
        child: GridTile(
          child: Hero(
            tag: person.id!,
            child: Container(
              height: double.infinity,
              color: AppColors.scaffoldBackgroundColor,
              child: person.profilePath != null
                  ? CachedNetworkImage(
                      placeholder: (context, index) =>
                          Image.asset(ImageAssets.loadingIMG),
                      imageUrl: EndPoints.imageUrl + person.profilePath!,
                      fit: BoxFit.cover,
                    )
                  : Image.asset(ImageAssets.placeHolderIMG),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.center,
            child: Text(
              // character.name,
              person.name!,
              style: Theme.of(context).textTheme.headline5,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
