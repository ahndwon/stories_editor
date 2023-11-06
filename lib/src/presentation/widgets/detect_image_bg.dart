import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stories_editor/src/presentation/utils/color_detection.dart';

class DetectImageBg extends StatefulWidget {
  const DetectImageBg({
    super.key,
    required this.child,
    required this.generatedGradient,
  });

  final Widget child;
  final void Function(Color color1, Color color2) generatedGradient;

  @override
  DetectImageBgState createState() => DetectImageBgState();
}

class DetectImageBgState extends State<DetectImageBg> {
  GlobalKey childKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();

  GlobalKey? currentKey;

  final StreamController<Color> stateController = StreamController<Color>();
  Color color1 = const Color(0xFFFFFFFF);
  Color color2 = const Color(0xFFFFFFFF);

  @override
  void initState() {
    currentKey = paintKey;
    Timer.periodic(const Duration(milliseconds: 500), (callback) async {
      final currentState = childKey.currentState;
      // log('DetectImageBg - initState : $currentState');
      if (currentState != null) {
        if (currentState.context.size?.height != 0.0) {
          final cd1 = await ColorDetection(
            currentKey: currentKey,
            paintKey: paintKey,
            stateController: stateController,
          ).searchPixel(
            Offset(currentState.context.size!.width / 2, 480),
          ) as Color;
          final cd12 = await ColorDetection(
            currentKey: currentKey,
            paintKey: paintKey,
            stateController: stateController,
          ).searchPixel(
            Offset(currentState.context.size!.width / 2.03, 530),
          ) as Color;
          log('DetectImageBg - detectedColor : $cd1, $cd12');
          color1 = cd1;
          color2 = cd12;
          widget.generatedGradient(color1, color2);
          setState(() {});
          callback.cancel();
          await stateController.close();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: paintKey,
      child: Center(
        child: SizedBox(
          key: childKey,
          child: widget.child,
        ),
      ),
    );
  }
}
