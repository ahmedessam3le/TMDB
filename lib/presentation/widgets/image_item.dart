import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tmdb/config/routes/app_routes.dart';
import 'package:tmdb/core/api/end_points.dart';
import 'package:tmdb/core/utils/app_colors.dart';
import 'package:tmdb/core/utils/app_responsive.dart';
import 'package:tmdb/core/utils/assets_manager.dart';
import 'package:tmdb/data/models/images_model.dart';

class ImageItem extends StatelessWidget {
  final ImageModel imageModel;
  const ImageItem({Key? key, required this.imageModel}) : super(key: key);

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
        onTap: () => Navigator.of(context)
            .pushNamed(Routes.imagePreview, arguments: imageModel),
        child: Hero(
          tag: imageModel.filePath!,
          child: Container(
              height: double.infinity,
              color: AppColors.scaffoldBackgroundColor,
              child: CachedNetworkImage(
                placeholder: (context, index) =>
                    Image.asset(ImageAssets.loadingIMG),
                imageUrl: EndPoints.imageUrl + imageModel.filePath!,
                fit: BoxFit.cover,
              )),
        ),
      ),
    );
  }
}
