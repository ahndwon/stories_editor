import 'dart:io';

import 'package:align_positioned/align_positioned.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_gif_picker/modal_gif_picker.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/models/editable_items.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/gradient_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/presentation/utils/constants/app_enums.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';

class DraggableWidget extends StatelessWidget {
  const DraggableWidget({
    super.key,
    required this.context,
    required this.item,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerMove,
    this.isSelected = false,
  });

  final EditableItem item;
  final void Function(PointerDownEvent)? onPointerDown;
  final void Function(PointerUpEvent)? onPointerUp;
  final void Function(PointerMoveEvent)? onPointerMove;
  final BuildContext context;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil();
    final colorProvider =
        Provider.of<GradientNotifier>(this.context, listen: false);
    final controlProvider =
        Provider.of<ControlNotifier>(this.context, listen: false);
    Widget? contentWidget;

    BoxDecoration? decoration;
    if (isSelected) {
      decoration = BoxDecoration(
        border: Border.all(
          color: const Color(0xFFF2AC3C),
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );
    }

    switch (item.type) {
      case ItemType.text:
        contentWidget = IntrinsicWidth(
          child: IntrinsicHeight(
            child: Container(
              constraints: BoxConstraints(
                minHeight: 50,
                minWidth: 50,
                maxWidth: screenUtil.screenWidth - 240.w,
              ),
              decoration: decoration,
              width: item.deletePosition ? 100 : null,
              height: item.deletePosition ? 100 : null,
              child: AnimatedOnTapButton(
                onTap: () => _onTap(context, item, controlProvider),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Center(
                      child: _text(
                        background: true,
                        paintingStyle: PaintingStyle.fill,
                        controlNotifier: controlProvider,
                      ),
                    ),
                    IgnorePointer(
                      child: Center(
                        child: _text(
                          background: true,
                          paintingStyle: PaintingStyle.stroke,
                          controlNotifier: controlProvider,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 2.5, top: 2),
                      child: Stack(
                        children: [
                          Center(
                            child: _text(
                              paintingStyle: PaintingStyle.fill,
                              controlNotifier: controlProvider,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
        break;

      /// image [file_image_gb.dart]
      case ItemType.image:
        final imageUrl = item.imageUrl;
        final imageWidth = screenUtil.screenWidth - 200.w;

        if (imageUrl != null && imageUrl.isNotEmpty) {
          Widget? imageWidget = const SizedBox();
          if (imageUrl.startsWith('http') || imageUrl.startsWith('https')) {
            // final screenSize = MediaQuery.of(context).size;
            imageWidget = Image.network(
              imageUrl,
              width: imageWidth,
            );
          } else {
            imageWidget = Image.file(File(imageUrl), width: imageWidth);
          }
          contentWidget = Container(
            decoration: decoration,
            child: imageWidget,
          );
        } else {
          contentWidget = Container();
        }
        // if (controlProvider.mediaPath.isNotEmpty) {
        //   contentWidget = SizedBox(
        //     width: screenUtil.screenWidth - 144.w,
        //     child: FileImageBG(
        //       filePath: File(controlProvider.mediaPath),
        //       generatedGradient: (color1, color2) {
        //         colorProvider
        //           ..color1 = color1
        //           ..color2 = color2;
        //       },
        //     ),
        //   );
        // } else {
        //   contentWidget = Container();
        // }

        break;

      case ItemType.gif:
        contentWidget = SizedBox(
          width: 150,
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            children: [
              /// create Gif widget
              Center(
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: isSelected ? decoration : const BoxDecoration(),
                  child: GiphyRenderImage(
                    key: ValueKey(item.gif.id),
                    url: item.gif.url,
                    renderGiphyOverlay: false,
                  ),
                ),
              ),
            ],
          ),
        );
        break;

      case ItemType.video:
        contentWidget = const Center();
        break;
    }

    /// set widget data position on main screen
    return OverflowBox(
      child: AnimatedAlignPositioned(
        duration: const Duration(milliseconds: 100),
        dy: item.deletePosition
            ? _deleteTopOffset()
            : (item.position.dy * screenUtil.screenHeight),
        dx: item.deletePosition
            ? 0
            : (item.position.dx * screenUtil.screenWidth),
        alignment: Alignment.center,
        child: Transform.scale(
          scale: item.deletePosition ? _deleteScale() : item.scale,
          child: Transform.rotate(
            angle: item.rotation,
            child: Listener(
              onPointerDown: onPointerDown,
              onPointerUp: onPointerUp,
              onPointerMove: onPointerMove,

              /// show widget
              child: buildEditingUserFrame(child: contentWidget),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditingUserFrame({required Widget child}) {
    final nowMilli = DateTime.now().millisecondsSinceEpoch;
    final startedAtMilli =
        item.editingUser?.receivedAt?.millisecondsSinceEpoch ?? 0;
    const showUserOffset = 500;
    final isOver = nowMilli - startedAtMilli > showUserOffset;

    final showColor = isOver
        ? Colors.transparent
        : (item.editingUser?.backgroundColor ?? Colors.transparent);

    final textColor = isOver ? Colors.transparent : Colors.black;

    const radius = Radius.circular(2);
    const nameHeight = 14.0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: nameHeight,
          padding: const EdgeInsets.symmetric(horizontal: 2),
          decoration: BoxDecoration(
            color: showColor,
            borderRadius:
                const BorderRadius.only(topLeft: radius, topRight: radius),
            border: Border.all(
              color: showColor,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Text(
            item.editingUser?.username ?? '',
            style: TextStyle(
              color: textColor,
              fontSize: 12,
            ),
          ),
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(
              color: showColor,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: child,
        ),
        const SizedBox(height: nameHeight),
      ],
    );
  }

  /// text widget
  Widget _text({
    required ControlNotifier controlNotifier,
    required PaintingStyle paintingStyle,
    bool background = false,
  }) {
    if (item.animationType == TextAnimationType.none) {
      return Text(
        item.text,
        textAlign: item.textAlign,
        style: _textStyle(
          controlNotifier: controlNotifier,
          paintingStyle: paintingStyle,
          background: background,
        ),
      );
    } else {
      return DefaultTextStyle(
        style: _textStyle(
          controlNotifier: controlNotifier,
          paintingStyle: paintingStyle,
          background: background,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          onTap: () => _onTap(context, item, controlNotifier),
          animatedTexts: [
            if (item.animationType == TextAnimationType.scale)
              ScaleAnimatedText(
                item.text,
                duration: const Duration(milliseconds: 1200),
              ),
            if (item.animationType == TextAnimationType.fade)
              ...item.textList.map(
                (item) => FadeAnimatedText(
                  item,
                  duration: const Duration(milliseconds: 1200),
                ),
              ),
            if (item.animationType == TextAnimationType.typer)
              TyperAnimatedText(
                item.text,
                speed: const Duration(milliseconds: 500),
              ),
            if (item.animationType == TextAnimationType.typeWriter)
              TypewriterAnimatedText(
                item.text,
                speed: const Duration(milliseconds: 500),
              ),
            if (item.animationType == TextAnimationType.wavy)
              WavyAnimatedText(
                item.text,
                speed: const Duration(milliseconds: 500),
              ),
            if (item.animationType == TextAnimationType.flicker)
              FlickerAnimatedText(
                item.text,
                speed: const Duration(milliseconds: 1200),
              ),
          ],
        ),
      );
    }
  }

  TextStyle _textStyle({
    required ControlNotifier controlNotifier,
    required PaintingStyle paintingStyle,
    bool background = false,
  }) {
    return TextStyle(
      fontFamily: controlNotifier.fontList![item.fontFamily],
      package: controlNotifier.isCustomFontList ? null : 'stories_editor',
      fontWeight: FontWeight.w500,
      // shadows: <Shadow>[
      //   Shadow(
      //       offset: const Offset(0, 0),
      //       //blurRadius: 3.0,
      //       color: draggableWidget.textColor == Colors.black
      //           ? Colors.white54
      //           : Colors.black)
      // ]
    ).copyWith(
      color: background ? Colors.black : item.textColor,
      fontSize: item.deletePosition ? 8 : item.fontSize,
      background: Paint()
        ..strokeWidth = 20.0
        ..color = item.backGroundColor
        ..style = paintingStyle
        ..strokeJoin = StrokeJoin.round
        ..filterQuality = FilterQuality.high
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.solid, 1),
    );
  }

  double _deleteTopOffset() {
    var top = 0.0;
    final screenUtil = ScreenUtil();
    if (item.type == ItemType.text) {
      return top = screenUtil.screenWidth / 1.2;
    } else if (item.type == ItemType.gif) {
      return top = screenUtil.screenWidth / 1.18;
    } else {
      return top;
    }
  }

  double _deleteScale() {
    var scale = 0.0;
    if (item.type == ItemType.text) {
      return scale = 0.4;
    } else if (item.type == ItemType.gif) {
      return scale = 0.3;
    } else {
      return scale;
    }
  }

  /// onTap text
  void _onTap(
    BuildContext context,
    EditableItem item,
    ControlNotifier controlNotifier,
  ) {
    final editorProvider =
        Provider.of<TextEditingNotifier>(this.context, listen: false);
    final itemProvider =
        Provider.of<DraggableWidgetNotifier>(this.context, listen: false);

    /// load text attributes
    editorProvider.textController.text = item.text.trim();
    editorProvider
      ..text = item.text.trim()
      ..fontFamilyIndex = item.fontFamily
      ..textSize = item.fontSize
      ..backGroundColor = item.backGroundColor
      ..textAlign = item.textAlign
      ..textColor = controlNotifier.colorList!.indexOf(item.textColor)
      ..animationType = item.animationType
      ..textList = item.textList
      ..fontAnimationIndex = item.fontAnimationIndex;
    itemProvider.draggableWidget
        .removeAt(itemProvider.draggableWidget.indexOf(item));
    editorProvider.fontFamilyController = PageController(
      initialPage: item.fontFamily,
      viewportFraction: .1,
    );

    /// create new text item
    controlNotifier.isTextEditing = !controlNotifier.isTextEditing;
  }
}
