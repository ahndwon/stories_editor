import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stories_editor/src/presentation/utils/color_detection.dart';

class FileImageBG extends StatefulWidget {
  const FileImageBG({
    super.key,
    required this.filePath,
    required this.generatedGradient,
  });

  final File? filePath;
  final void Function(Color color1, Color color2) generatedGradient;

  @override
  FileImageBGState createState() => FileImageBGState();
}

class FileImageBGState extends State<FileImageBG> {
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();

  GlobalKey? currentKey;

  final StreamController<Color> stateController = StreamController<Color>();
  Color color1 = const Color(0xFFFFFFFF);
  Color color2 = const Color(0xFFFFFFFF);

  @override
  void initState() {
    currentKey = paintKey;
    Timer.periodic(const Duration(milliseconds: 500), (callback) async {
      final currentState = imageKey.currentState;
      // log('FileImageBg - initState : $currentState');

      if (currentState != null) {
        if (currentState.context.size?.height != 0.0) {

          final screenSize = MediaQuery.of(currentState.context).size;

          final cd1 = await ColorDetection(
            currentKey: currentKey,
            paintKey: paintKey,
            stateController: stateController,
          ).searchPixel(
            Offset(imageKey.currentState!.context.size!.width / 2, screenSize.height / 2),
          ) as Color;
          final cd12 = await ColorDetection(
            currentKey: currentKey,
            paintKey: paintKey,
            stateController: stateController,
          ).searchPixel(
            Offset(imageKey.currentState!.context.size!.width / 2.03, screenSize.height / 2),
          ) as Color;
          color1 = cd1;
          color2 = cd12;
          log('FileImageBg - detectedColor : $cd1, $cd12');
          setState(() {});
          widget.generatedGradient(color1, color2);
          callback.cancel();
          await stateController.close();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil();
    return SizedBox(
      height: screenUtil.screenHeight,
      width: screenUtil.screenWidth,
      child: RepaintBoundary(
        key: paintKey,
        child: Center(
          child: Image.file(
            File(widget.filePath!.path),
            key: imageKey,
            filterQuality: FilterQuality.high,
            width: 300,
          ),
        ),
      ),
    );
  }
}
