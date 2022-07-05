import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tmdb/core/api/end_points.dart';
import 'package:tmdb/core/utils/app_constants.dart';
import 'package:tmdb/core/utils/app_strings.dart';
import 'package:tmdb/core/utils/assets_manager.dart';
import 'package:tmdb/data/models/images_model.dart';

class ImagePreviewScreen extends StatelessWidget {
  final ImageModel imageModel;
  ImagePreviewScreen({Key? key, required this.imageModel}) : super(key: key);

  void _downloadImage() async {
    AppConstants.showToast(
        message: AppStrings.downloading, toastColor: Colors.yellow);
    GallerySaver.saveImage(
      EndPoints.imageUrl + imageModel.filePath!,
      // toDcim: true,
      albumName: AppStrings.appName,
    ).then((success) {
      if (success!) {
        AppConstants.showToast(
            message: AppStrings.downloaded, toastColor: Colors.green);
      } else {
        AppConstants.showToast(
            message: AppStrings.downloadFailed, toastColor: Colors.red);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double imageHeight = double.parse(imageModel.height!.toString());
    double imageWidth = double.parse(imageModel.width!.toString());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            key: ValueKey('Download Button'),
            onPressed: _downloadImage,
            icon: Icon(Icons.file_download_outlined),
          ),
        ],
      ),
      body: Container(
        child: Hero(
          tag: imageModel.filePath!,
          child: Container(
            height: imageHeight,
            width: imageWidth,
            child: CachedNetworkImage(
              alignment: Alignment.center,
              placeholder: (context, index) =>
                  Image.asset(ImageAssets.loadingIMG),
              imageUrl: EndPoints.imageUrl + imageModel.filePath!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
