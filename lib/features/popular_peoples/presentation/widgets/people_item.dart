import 'package:flutter/material.dart';
import 'package:tmdb/core/utils/app_colors.dart';
import 'package:tmdb/core/utils/app_responsive.dart';
import 'package:tmdb/core/utils/assets_manager.dart';

class PeopleItem extends StatelessWidget {
  // final Character character;
  // const CharacterItem({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      margin: EdgeInsets.symmetric(vertical: 20.r, horizontal: 20.r),
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
            // tag: character.charID,
            tag: '1',
            child: Container(
              height: double.infinity,
              color: AppColors.scaffoldBackgroundColor,
              // child: character.image.isNotEmpty
              //     ? FadeInImage.assetNetwork(
              //   placeholder: ImageAssets.loadingIMG,
              //   image: character.image,
              //   fit: BoxFit.cover,
              // )
              //     : Image.asset(ImageAssets.placeHolderIMG),
              child: Image.asset(
                ImageAssets.placeHolderIMG,
                fit: BoxFit.cover,
              ),
            ),
          ),
          header: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.center,
            child: Text(
              // character.name,
              'Ahmed Essam',
              style: Theme.of(context).textTheme.headline5,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  // character.name,
                  'Rate',
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                SizedBox(width: 20.wp),
                Text(
                  // character.name,
                  '203',
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
