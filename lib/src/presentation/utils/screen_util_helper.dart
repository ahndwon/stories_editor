import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ScreenUtilNormalizer on ScreenUtil {
  double normalizeByScreenHeight(double value) {
    return value / screenHeight;
  }

  double normalizeByScreenWidth(double value) {
    return value / screenWidth;
  }

  double denormalizeByScreenHeight(double value) {
    return value * screenHeight;
  }

  double denormalizeByScreenWidth(double value) {
    return value * screenWidth;
  }

  double normalizeByScaleHeight(double value) {
    return value / scaleHeight;
  }

  double normalizeByScaleWidth(double value) {
    return value / scaleWidth;
  }

  double denormalizeByScaleHeight(double value) {
    return value * scaleHeight;
  }

  double denormalizeByScaleWidth(double value) {
    return value * scaleWidth;
  }
}
