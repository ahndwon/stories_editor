import 'dart:io';
import 'dart:math' as math;

import 'package:align_positioned/align_positioned.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/gradient_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/presentation/utils/constants/app_enums.dart';
import 'package:stories_editor/src/presentation/utils/screen_util_helper.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';

class DraggableWidget extends StatelessWidget {
  const DraggableWidget({
    super.key,
    required this.context,
    required this.item,
    this.onPointerDown,
    this.onPointerUp,
    this.onPointerMove,
    this.onDeleteTap,
    this.onScaleStart,
    this.onScaleMove,
    this.onFlipTap,
    this.isSelected = false,
    this.frame,
  });

  final StickerItem item;
  final void Function(PointerDownEvent)? onPointerDown;
  final void Function(PointerUpEvent)? onPointerUp;
  final void Function(PointerMoveEvent)? onPointerMove;
  final void Function(StickerItem)? onDeleteTap;
  final void Function(PointerDownEvent)? onScaleStart;
  final void Function(PointerMoveEvent)? onScaleMove;
  final void Function(StickerItem)? onFlipTap;
  final BuildContext context;
  final bool isSelected;
  final Widget? frame;

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
          width: 2,
          color: const Color(0xFFF2AC3C),
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
      );
    }

    switch (item.type) {
      case StickerItemType.text:
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
      case StickerItemType.image:
        final imageSticker = item as ImageSticker;
        final imageUrl = imageSticker.url;
        final imageWidth = screenUtil.screenWidth - 200.w;

        if (imageUrl.isNotEmpty) {
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

      case StickerItemType.giphy:
        final giphy = item as GiphySticker;
        contentWidget = SizedBox(
          width: 150,
          height: 150,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(8),
            decoration: isSelected ? decoration : const BoxDecoration(),
            child: Image.network(
              key: ValueKey(giphy.id),
              giphy.url,
              loadingBuilder: (
                context,
                child,
                loadingProgress,
              ) {
                if (loadingProgress?.cumulativeBytesLoaded !=
                    loadingProgress?.cumulativeBytesLoaded) {
                  return const CircularProgressIndicator();
                }
                return child;
              },
            ),
            // child: GiphyRenderImage(
            //   key: ValueKey(item.gif.id),
            //   url: item.gif.stillUrl,
            //   renderGiphyOverlay: false,
            // ),
          ),
        );
        break;

      case StickerItemType.frame:
        contentWidget = const Center();
        break;
    }

    /// set widget data position on main screen
    return OverflowBox(
      child: AnimatedAlignPositioned(
        duration: const Duration(milliseconds: 100),
        dy: item.deletePosition
            ? _deleteTopOffset()
            : screenUtil.denormalizeByScreenWidth(item.position.dy),
        dx: item.deletePosition
            ? 0
            : screenUtil.denormalizeByScreenWidth(item.position.dx),
        alignment: Alignment.center,
        child: Transform.rotate(
          angle: item.rotation,
          child: Listener(
            onPointerDown: onPointerDown,
            onPointerUp: onPointerUp,
            onPointerMove: onPointerMove,

            /// show widget
            child: buildEditFrame(
              isShow: isSelected,
              child: buildEditingUserFrame(
                child: Transform(
                  alignment: Alignment.center,
                  transform: item.isFlip
                      ? Matrix4.rotationY(math.pi)
                      : Matrix4.identity(),
                  child: contentWidget,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildEditFrame({required Widget child, required bool isShow}) {
    return Stack(
      children: [
        // DecoratedBox(
        //   decoration: BoxDecoration(
        //     border: Border.all(
        //       color: const Color(0xFFF2AC3C),
        //       strokeAlign: BorderSide.strokeAlignOutside,
        //     ),
        //   ),
        //   child: child,
        // ),
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 24,
          ),
          child: child,
        ),
        Visibility(
          visible: isShow,
          child: Positioned(
            left: 0,
            top: 0,
            child: IconButton(
              onPressed: () {
                onDeleteTap?.call(item);
              },
              icon: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.close,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isShow,
          child: Positioned(
            right: 0,
            top: 0,
            child: Listener(
              onPointerDown: (details) {
                onScaleStart?.call(details);
              },
              onPointerMove: (details) {
                onScaleMove?.call(details);
              },
              child: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.rotate_left,
                  size: 32,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isShow,
          child: Positioned(
            bottom: 0,
            right: 0,
            child: IconButton(
              onPressed: () {
                item.isFlip = !item.isFlip;
                onFlipTap?.call(item);
              },
              icon: const DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  Icons.flip,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
      ],
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
    final textItem = item as TextSticker;
    if (textItem.animationType == TextAnimationType.none) {
      return Text(
        textItem.text,
        textAlign: textItem.textAlign,
        style: _textStyle(
          controlNotifier: controlNotifier,
          textItem: textItem,
          paintingStyle: paintingStyle,
          background: background,
        ),
      );
    } else {
      return DefaultTextStyle(
        style: _textStyle(
          controlNotifier: controlNotifier,
          textItem: textItem,
          paintingStyle: paintingStyle,
          background: background,
        ),
        child: AnimatedTextKit(
          repeatForever: true,
          onTap: () => _onTap(context, textItem, controlNotifier),
          animatedTexts: [
            if (textItem.animationType == TextAnimationType.scale)
              ScaleAnimatedText(
                textItem.text,
                duration: const Duration(milliseconds: 1200),
              ),
            if (textItem.animationType == TextAnimationType.fade)
              ...textItem.textList.map(
                (textItem) => FadeAnimatedText(
                  textItem,
                  duration: const Duration(milliseconds: 1200),
                ),
              ),
            if (textItem.animationType == TextAnimationType.typer)
              TyperAnimatedText(
                textItem.text,
                speed: const Duration(milliseconds: 500),
              ),
            if (textItem.animationType == TextAnimationType.typeWriter)
              TypewriterAnimatedText(
                textItem.text,
                speed: const Duration(milliseconds: 500),
              ),
            if (textItem.animationType == TextAnimationType.wavy)
              WavyAnimatedText(
                textItem.text,
                speed: const Duration(milliseconds: 500),
              ),
            if (textItem.animationType == TextAnimationType.flicker)
              FlickerAnimatedText(
                textItem.text,
                speed: const Duration(milliseconds: 1200),
              ),
          ],
        ),
      );
    }
  }

  TextStyle _textStyle({
    required ControlNotifier controlNotifier,
    required TextSticker textItem,
    required PaintingStyle paintingStyle,
    bool background = false,
  }) {
    return TextStyle(
      fontFamily: controlNotifier.fontList![textItem.fontFamily],
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
      color: background ? Colors.black : textItem.textColor,
      fontSize: textItem.deletePosition ? 8 : textItem.fontSize,
      background: Paint()
        ..strokeWidth = 20.0
        ..color = textItem.backGroundColor
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
    if (item.type == StickerItemType.text) {
      return top = screenUtil.screenWidth / 1.2;
    } else if (item.type == StickerItemType.giphy) {
      return top = screenUtil.screenWidth / 1.18;
    } else {
      return top;
    }
  }

  double _deleteScale() {
    var scale = 0.0;
    if (item.type == StickerItemType.text) {
      return scale = 0.4;
    } else if (item.type == StickerItemType.giphy) {
      return scale = 0.3;
    } else {
      return scale;
    }
  }

  /// onTap text
  void _onTap(
    BuildContext context,
    StickerItem item,
    ControlNotifier controlNotifier,
  ) {
    item as TextSticker;
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
