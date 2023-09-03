// ignore_for_file: must_be_immutable

import 'dart:io' as io;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/gradient_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/scroll_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/presentation/bar_tools/main_tools.dart';
import 'package:stories_editor/src/presentation/bar_tools/top_tool_bar.dart';
import 'package:stories_editor/src/presentation/draggable_items/delete_item.dart';
import 'package:stories_editor/src/presentation/draggable_items/draggable_widget.dart';
import 'package:stories_editor/src/presentation/painting_view/painting.dart';
import 'package:stories_editor/src/presentation/painting_view/widgets/sketcher.dart';
import 'package:stories_editor/src/presentation/text_editor_view/TextEditor.dart';
import 'package:stories_editor/src/presentation/utils/Extensions/context_extension.dart';
import 'package:stories_editor/src/presentation/utils/modal_sheets.dart';
import 'package:stories_editor/stories_editor.dart';

class MainView extends StatefulWidget {
  MainView({
    super.key,
    required this.giphyKey,
    required this.onDone,
    this.middleBottomWidget,
    this.centerWidgetBuilder,
    this.colorList,
    this.isCustomFontList,
    this.fontFamilyList,
    this.gradientColors,
    this.onBackPress,
    this.onDoneButtonStyle,
    this.editorBackgroundColor,
    this.galleryThumbnailQuality,
    this.onMoveDraggable,
    this.onMoveEndDraggable,
    this.onRemoveDraggable,
    this.onChatButtonClick,
    this.onAddCutContent,
    this.onInteractionEnd,
    this.title,
    this.actions,
    this.onUndo,
    this.onRedo,
  });

  /// editor custom font families
  final List<String>? fontFamilyList;

  /// editor custom font families package
  final bool? isCustomFontList;

  /// giphy api key
  final String giphyKey;

  /// editor custom color gradients
  final List<List<Color>>? gradientColors;

  /// editor custom logo
  final Widget? middleBottomWidget;

  /// widget for title
  final Widget? title;

  /// center widget
  final Widget Function(BuildContext context, ScreenUtil screenUtil)?
      centerWidgetBuilder;

  /// on done
  final void Function(String)? onDone;

  /// on done button Text
  final Widget? onDoneButtonStyle;

  /// on back pressed
  final Future<bool>? onBackPress;

  /// editor background color
  Color? editorBackgroundColor;

  /// gallery thumbnail quality
  final int? galleryThumbnailQuality;

  /// editor custom color palette list
  List<Color>? colorList;

  // on move item
  final void Function(StickerItem)? onMoveDraggable;

  // on move end item
  final void Function(StickerItem)? onMoveEndDraggable;

  // item remove callback
  final void Function(String)? onRemoveDraggable;

  // chat button click callback
  final void Function()? onChatButtonClick;

  // undo button click callback
  final void Function()? onUndo;

  // redo button click callback
  final void Function()? onRedo;

  // top tool bar actions
  final List<Widget>? actions;

  // on cut content added
  final void Function(XFile xFile, String id, Matrix4 matrix4)? onAddCutContent;

  // on cut sticker interaction end
  final void Function(String id, Matrix4 matrix4)? onInteractionEnd;

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  /// content container key
  final GlobalKey contentKey = GlobalKey();

  ///Editable item
  StickerItem? _activeItem;

  /// Gesture Detector listen changes
  Offset _initPos = Offset.zero;
  Offset _currentPos = Offset.zero;
  Size _initSize = Size.zero;
  double _currentScale = 1;
  double _currentRotation = 0;

  /// delete position
  bool _isDeletePosition = false;
  bool _inAction = false;

  Map<String, GlobalKey> draggableKeys = {};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final control = Provider.of<ControlNotifier>(context, listen: false)
        ..giphyKey = widget.giphyKey
        ..middleBottomWidget = widget.middleBottomWidget
        ..isCustomFontList = widget.isCustomFontList ?? false;

      if (widget.gradientColors != null) {
        control.gradientColors = widget.gradientColors;
      }
      if (widget.fontFamilyList != null) {
        control.fontList = widget.fontFamilyList;
      }
      if (widget.colorList != null) {
        control.colorList = widget.colorList;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenUtil = ScreenUtil();
    return WillPopScope(
      onWillPop: _popScope,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          // backgroundColor: Colors.green,
          actions: widget.actions,
          title: widget.title,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.dark,
          ),
        ),
        body: Material(
          color: widget.editorBackgroundColor == Colors.transparent
              ? Colors.black
              : widget.editorBackgroundColor ?? Colors.black,
          child: Consumer6<
              ControlNotifier,
              DraggableWidgetNotifier,
              ScrollNotifier,
              GradientNotifier,
              PaintingNotifier,
              TextEditingNotifier>(
            builder: (
              context,
              controlNotifier,
              itemProvider,
              scrollProvider,
              colorProvider,
              paintingProvider,
              editingProvider,
              child,
            ) {
              return buildMainView(
                controlNotifier,
                screenUtil,
                colorProvider,
                itemProvider,
                context,
                paintingProvider,
              );
            },
          ),
        ),
      ),
    );
  }

  Column buildMainView(
    ControlNotifier controlNotifier,
    ScreenUtil screenUtil,
    GradientNotifier colorProvider,
    DraggableWidgetNotifier itemProvider,
    BuildContext context,
    PaintingNotifier paintingProvider,
  ) {
    final statusBarPadding = getStatusBarPadding();

    return Column(
      children: [
        SizedBox(height: statusBarPadding),

        /// bottom tools
        AspectRatio(
          aspectRatio: 9 / 16,
          // aspectRatio: 3 / 4,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ///gradient container
              /// this container will contain all widgets(image/texts/draws/sticker)
              /// wrap this widget with coloredFilter
              GestureDetector(
                onScaleStart: _onScaleStart,
                onScaleUpdate: _onScaleUpdate,
                onTap: () {
                  // controlNotifier.isTextEditing =
                  //     !controlNotifier.isTextEditing;
                  setState(() {
                    _activeItem = null;
                  });
                },
                child: Align(
                  // alignment: Alignment.topCenter,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: SizedBox(
                      width: screenUtil.screenWidth,
                      child: RepaintBoundary(
                        key: contentKey,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                          decoration: BoxDecoration(
                            gradient: controlNotifier.mediaPath.isEmpty
                                ? LinearGradient(
                                    colors: controlNotifier.gradientColors![
                                        controlNotifier.gradientIndex],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : LinearGradient(
                                    colors: [
                                      colorProvider.color1,
                                      colorProvider.color2
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                          ),
                          child: GestureDetector(
                            onScaleStart: _onScaleStart,
                            onScaleUpdate: _onScaleUpdate,
                            behavior: HitTestBehavior.deferToChild,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                /// in this case photo view works
                                /// as a main background container
                                /// to manage
                                /// the gestures of all
                                /// movable items.
                                PhotoView.customChild(
                                  backgroundDecoration: const BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: Container(),
                                ),

                                // widget.centerWidgetBuilder
                                //         ?.call(context, screenUtil) ??
                                //     const SizedBox(),

                                ///list items
                                ...itemProvider
                                    .getDistinctDraggableWidget()
                                    .toList()
                                    .map((editableItem) {
                                  final draggable = DraggableWidget(
                                    key: _getOrAddKey(editableItem),
                                    item: editableItem,
                                    isSelected:
                                        editableItem.id == _activeItem?.id,
                                    onDeleteTap: (item) {
                                      setState(() {
                                        itemProvider.remove(item.id);
                                        widget.onRemoveDraggable?.call(item.id);
                                        HapticFeedback.heavyImpact();
                                      });
                                    },
                                    onFlipTap: (item) {
                                      setState(() {});
                                      widget.onMoveEndDraggable?.call(item);
                                    },
                                    onPointerDown: (details) {
                                      _updateItemPosition(
                                        editableItem,
                                        details,
                                      );
                                    },
                                    onPointerUp: (details) {
                                      _deleteItemOnCoordinates(
                                        editableItem,
                                        details,
                                      );
                                      widget.onMoveEndDraggable
                                          ?.call(editableItem);
                                    },
                                    onPointerMove: (details) {
                                      _deletePosition(
                                        editableItem,
                                        details,
                                      );
                                      widget.onMoveDraggable
                                          ?.call(editableItem);
                                    },
                                    onAddCutContent: (
                                      XFile xFile,
                                      String id,
                                      Matrix4 matrix4,
                                    ) {
                                      widget.onAddCutContent?.call(
                                        xFile,
                                        id,
                                        matrix4,
                                      );
                                    },
                                    onInteractionEnd: (id, matrix4) {
                                      widget.onInteractionEnd?.call(
                                        id,
                                        matrix4,
                                      );
                                    },
                                  );

                                  return AnimatedPositioned(
                                    duration:
                                        const Duration(milliseconds: 4000),
                                    curve: Curves.easeIn,
                                    child: draggable,
                                  );
                                }),

                                /// finger paint
                                IgnorePointer(
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: buildFingerPaint(
                                      screenUtil,
                                      paintingProvider,
                                    ),
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    color: Colors.red,
                                    width: 1,
                                  ),
                                ),
                                Center(
                                  child: Container(
                                    color: Colors.red,
                                    height: 1,
                                  ),
                                ),
                                // Align(
                                //   alignment: Alignment.bottomCenter,
                                //   child: Padding(
                                //     padding: const EdgeInsets.only(bottom: 100),
                                //     child: OutlinedButton(
                                //       child: const Text('Change value'),
                                //       onPressed: () {
                                //         setState(() {
                                //           _isInitialValue = !_isInitialValue;
                                //         });
                                //       },
                                //     ),
                                //   ),
                                // ),
                                if (!context.isLongerThan9to16Ratio)
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      height: 20,
                                      color: Colors.white.withOpacity(0.15),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              /// middle text
              if (itemProvider.draggableWidget.isEmpty &&
                  !controlNotifier.isTextEditing &&
                  paintingProvider.lines.isEmpty)
                IgnorePointer(
                  child: Align(
                    alignment: const Alignment(0, -0.1),
                    child: Text(
                      'Tap to type',
                      style: TextStyle(
                        fontFamily: 'Alegreya',
                        package: 'stories_editor',
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                        color: Colors.white.withOpacity(0.5),
                        shadows: <Shadow>[
                          Shadow(
                            offset: const Offset(1, 1),
                            blurRadius: 3,
                            color: Colors.black45.withOpacity(0.3),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

              /// delete item when the item is in position
              DeleteItem(
                activeItem: _activeItem,
                animationsDuration: const Duration(milliseconds: 300),
                isDeletePosition: _isDeletePosition,
              ),

              /// bottom tools
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildHelpTools(),
                    if (!context.isLongerThan9to16Ratio)
                      Visibility(
                        visible: !controlNotifier.isTextEditing &&
                            !controlNotifier.isPainting,
                        child: MainTools(
                          contentKey: contentKey,
                          context: context,
                        ),
                      ),
                  ],
                ),
              ),

              /// show text editor
              Visibility(
                visible: controlNotifier.isTextEditing,
                child: TextEditor(
                  context: context,
                ),
              ),

              /// show painting sketch
              Visibility(
                visible: controlNotifier.isPainting,
                child: const Painting(),
              ),
              if (isDebugMode)
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      Text(
                          'w: ${screenUtil.screenWidth.toInt()}, h: ${screenUtil.screenHeight.toInt()}'),
                    ],
                  ),
                ),
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // buildHelpTools(),
            if (context.isLongerThan9to16Ratio)
              Visibility(
                visible: !controlNotifier.isTextEditing &&
                    !controlNotifier.isPainting,
                child: MainTools(
                  contentKey: contentKey,
                  context: context,
                ),
              ),
          ],
        )
        // Container(
        //   height: 50.h,
        //   color: Colors.black,
        // ),
      ],
    );
  }

  GlobalKey<State<StatefulWidget>> _getOrAddKey(StickerItem editableItem) {
    final key = draggableKeys[editableItem.id];
    if (key != null) {
      return key;
    }
    final newKey = GlobalKey();
    draggableKeys[editableItem.id] = newKey;
    return newKey;
  }

  Widget buildFingerPaint(
    ScreenUtil screenUtil,
    PaintingNotifier paintingProvider,
  ) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
      ),
      child: RepaintBoundary(
        child: SizedBox(
          width: screenUtil.screenWidth,
          child: StreamBuilder<List<PaintingModel>>(
            stream: paintingProvider.linesStreamController.stream,
            builder: (context, snapshot) {
              return CustomPaint(
                painter: Sketcher(
                  lines: paintingProvider.lines,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget buildTopToolBar() {
    return TopToolBar(
      contentKey: contentKey,
      onDone: (bytes) {
        setState(() {
          widget.onDone!(bytes);
        });
      },
      onDoneButtonStyle: widget.onDoneButtonStyle,
      editorBackgroundColor: widget.editorBackgroundColor,
      actions: widget.actions,
      title: widget.title,
    );
  }

  // GalleryMediaPicker buildGalleryMediaPicker(
  //   ScrollNotifier scrollProvider,
  //   DraggableWidgetNotifier itemProvider,
  //   ControlNotifier controlNotifier,
  // ) {
  //   return GalleryMediaPicker(
  //     gridViewController: scrollProvider.gridController,
  //     thumbnailQuality: widget.galleryThumbnailQuality,
  //     onlyImages: true,
  //     appBarColor: widget.editorBackgroundColor ?? Colors.black,
  //     gridViewPhysics: itemProvider.draggableWidget.isEmpty
  //         ? const NeverScrollableScrollPhysics()
  //         : const ScrollPhysics(),
  //     pathList: (path) {
  //       controlNotifier.mediaPath = path.first.path!;
  //       if (controlNotifier.mediaPath.isNotEmpty) {
  //         itemProvider.insert(
  //           ImageSticker(
  //             id: const Uuid().v4(),
  //             url: path.first.path!,
  //           ),
  //         );
  //       }
  //       scrollProvider.pageController.animateToPage(
  //         0,
  //         duration: const Duration(milliseconds: 300),
  //         curve: Curves.easeIn,
  //       );
  //     },
  //     appBarLeadingWidget: Padding(
  //       padding: const EdgeInsets.only(bottom: 15, right: 15),
  //       child: Align(
  //         alignment: Alignment.bottomRight,
  //         child: AnimatedOnTapButton(
  //           onTap: () {
  //             scrollProvider.pageController.animateToPage(
  //               0,
  //               duration: const Duration(milliseconds: 300),
  //               curve: Curves.easeIn,
  //             );
  //           },
  //           child: Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
  //             decoration: BoxDecoration(
  //               color: Colors.transparent,
  //               borderRadius: BorderRadius.circular(10),
  //               border: Border.all(
  //                 color: Colors.white,
  //                 width: 1.2,
  //               ),
  //             ),
  //             child: const Text(
  //               'Cancel',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  /// validate pop scope gesture
  Future<bool> _popScope() async {
    final controlNotifier =
        Provider.of<ControlNotifier>(context, listen: false);

    /// change to false text editing
    if (controlNotifier.isTextEditing) {
      controlNotifier.isTextEditing = !controlNotifier.isTextEditing;
      return false;
    }

    /// change to false painting
    else if (controlNotifier.isPainting) {
      controlNotifier.isPainting = !controlNotifier.isPainting;
      return false;
    }

    /// show close dialog
    else if (!controlNotifier.isTextEditing && !controlNotifier.isPainting) {
      return widget.onBackPress ??
          exitDialog(context: context, contentKey: contentKey);
    }
    return false;
  }

  /// start item scale
  void _onScaleStart(ScaleStartDetails details) {
    if (_activeItem == null) {
      return;
    }
    _initPos = details.focalPoint;
    _initSize = _activeItem!.size;
    _currentPos = _activeItem!.position;
    _currentScale = _activeItem!.scale;
    _currentRotation = _activeItem!.rotation;
  }

  /// update item scale
  void _onScaleUpdate(ScaleUpdateDetails details) {
    final screenUtil = ScreenUtil();
    if (_activeItem == null) {
      return;
    }
    final delta = details.focalPoint - _initPos;

    final left = (delta.dx / screenUtil.screenWidth) + _currentPos.dx;
    final top = (delta.dy / screenUtil.screenWidth) + _currentPos.dy;
    final newScale = details.scale * _currentScale;
    // log('newScale: $newScale, ${details.scale}, $_currentScale');
    // log('newWidth: ${_activeItem!.size.width * newScale}');
    setState(() {
      _activeItem!
        ..position = Offset(left, top)
        ..rotation = details.rotation + _currentRotation;
      // _activeItem!.size = _initSize * newScale;
      if ((_activeItem!.size.width * newScale) < 1000) {
        _activeItem!.scale = newScale;
      }
    });
  }

  /// active delete widget with offset position
  void _deletePosition(StickerItem item, PointerMoveEvent details) {
    if (item.type == StickerItemType.text &&
        item.position.dy >= 0.75.h &&
        item.position.dx >= -0.4.w &&
        item.position.dx <= 0.2.w) {
      setState(() {
        _isDeletePosition = true;
        item.deletePosition = true;
      });
    } else if ((item.type == StickerItemType.giphy ||
            item.type == StickerItemType.image ||
            item.type == StickerItemType.cut) &&
        item.position.dy >= 0.7.h &&
        item.position.dx >= -0.35.w &&
        item.position.dx <= 0.15) {
      setState(() {
        _isDeletePosition = true;
        item.deletePosition = true;
      });
    } else {
      setState(() {
        _isDeletePosition = false;
        item.deletePosition = false;
      });
    }
  }

  /// delete item widget with offset position
  void _deleteItemOnCoordinates(StickerItem item, PointerUpEvent details) {
    final itemProvider =
        Provider.of<DraggableWidgetNotifier>(context, listen: false);
    _inAction = false;
    if (item.type == StickerItemType.image &&
        item.position.dy >= 0.62.h &&
        item.position.dx >= -0.35.w &&
        item.position.dx <= 0.15) {
      setState(() {
        itemProvider.remove(item.id);
        widget.onRemoveDraggable?.call(item.id);
        HapticFeedback.heavyImpact();
      });
    } else if (item.type == StickerItemType.text &&
            item.position.dy >= 0.75.h &&
            item.position.dx >= -0.4.w &&
            item.position.dx <= 0.2.w ||
        item.type == StickerItemType.giphy &&
            item.position.dy >= 0.62.h &&
            item.position.dx >= -0.35.w &&
            item.position.dx <= 0.15) {
      setState(() {
        itemProvider.remove(item.id);
        widget.onRemoveDraggable?.call(item.id);
        HapticFeedback.heavyImpact();
      });
    }
  }

  /// update item position, scale, rotation
  void _updateItemPosition(StickerItem item, PointerDownEvent details) {
    if (_inAction) {
      return;
    }
    print('_updateItemPosition : $item');

    _inAction = true;
    _activeItem = item;
    _initPos = details.position;
    _currentPos = item.position;
    _currentScale = item.scale;
    _currentRotation = item.rotation;

    /// set vibrate
    HapticFeedback.lightImpact();
  }

  Widget buildHelpTools() {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.navigate_before_rounded,
            color: widget.onUndo == null ? Colors.grey : Colors.white,
            size: 32,
          ),
          enableFeedback: true,
          onPressed: widget.onUndo == null ? null : () => widget.onUndo?.call(),
        ),
        IconButton(
          icon: Icon(
            Icons.navigate_next_rounded,
            color: widget.onRedo == null ? Colors.grey : Colors.white,
            size: 32,
          ),
          enableFeedback: true,
          onPressed: widget.onRedo == null ? null : () => widget.onRedo?.call(),
        ),
        const Expanded(child: SizedBox()),
        IconButton(
          icon: const Icon(
            Icons.chat_bubble,
            color: Colors.white,
          ),
          onPressed: widget.onChatButtonClick,
        ),
      ],
    );
  }

  double getStatusBarPadding() {
    var statusBarPadding = 0.0;
    if (context.isLongerThan9to16Ratio) {
      if (io.Platform.isIOS) {
        statusBarPadding = 66.0;
      } else {
        statusBarPadding = 40.0;
      }
    }
    return statusBarPadding;
  }
}
