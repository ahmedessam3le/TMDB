import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tmdb/core/utils/app_colors.dart';
import 'package:tmdb/core/utils/app_responsive.dart';

class AppConstants {
  static void showErrorDialog({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(
            message,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Ok'),
              style: TextButton.styleFrom(
                primary: Colors.black,
                textStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static void showToast({
    required String message,
    Color? toastColor,
    ToastGravity? toastGravity,
  }) {
    Fluttertoast.showToast(
      toastLength: Toast.LENGTH_LONG,
      backgroundColor: toastColor ?? AppColors.primaryColor,
      gravity: toastGravity ?? ToastGravity.TOP,
      fontSize: 18.sp,
      textColor: Colors.white,
      msg: message,
    );
  }

  static Widget showLoadingIndicator() {
    return Center(
      child: SpinKitFadingCircle(
        color: AppColors.primaryColor,
      ),
    );
  }
}
