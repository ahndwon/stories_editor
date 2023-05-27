import 'package:flutter/cupertino.dart';
import 'package:stories_editor/src/presentation/utils/Extensions/double_extension.dart';

extension ContextExtension on BuildContext {
  static final by9to16Ratio = (9 / 16).toPrecision(2);

  double get deviceRatio {
    final deviceSize = MediaQuery.of(this).size;
    return (deviceSize.width / deviceSize.height).toPrecision(2);
  }

  bool get isLongerThan9to16Ratio {
    return deviceRatio < by9to16Ratio;
  }
}
