import 'dart:math';

import 'package:get/get.dart';

double _heightAspectRatio = Get.height / 781.0909090909091;
double _widthAspectRatio = Get.width / 392.72727272727275;

extension PercentSize on num {
  // double get hp => (Get.height * (this / 100));
  // double get wp => (Get.width * (this / 100));
  double get hp => this * _heightAspectRatio;
  double get wp => this * _widthAspectRatio;
  double get r => this * min(_widthAspectRatio, _heightAspectRatio);
}

extension ResponsiveText on num {
  // double get sp => Get.width.round() / 100 * (this / 4);
  double get sp =>
      this * min(_widthAspectRatio, _heightAspectRatio) * Get.textScaleFactor;
}
