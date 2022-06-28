import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tmdb/core/utils/app_colors.dart';
import 'package:tmdb/core/utils/app_responsive.dart';

class AppErrorWidget extends StatelessWidget {
  final VoidCallback? onPress;
  const AppErrorWidget({Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            color: AppColors.primaryColor,
            size: 200.r,
          ),
          Text(
            'Something Went Wrong',
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primaryColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.hp),
            child: Text(
              'Please try again',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.hintColor,
              ),
            ),
          ),
          Container(
            height: 55.hp,
            width: context.width * 0.55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: AppColors.primaryColor,
                onPrimary: AppColors.primaryColor,
                elevation: 500,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50.r),
                ),
              ),
              onPressed: () {
                if (onPress != null) {
                  onPress!();
                }
              },
              child: Text(
                'Reload Screen',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
