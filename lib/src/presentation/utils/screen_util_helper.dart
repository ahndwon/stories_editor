import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ScreenUtilNormalizer on ScreenUtil {
  double normalizeByHeight(double value) {
    return value / screenHeight;
  }

  double normalizeByWidth(double value) {
    return value / screenWidth;
  }

  double denormalizeByHeight(double value) {
    return value * screenHeight;
  }

  double denormalizeByWidth(double value) {
    return value * screenWidth;
  }
}
