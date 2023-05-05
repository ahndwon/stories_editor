// ignore_for_file: must_be_immutable

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/models/editable_items.dart';
import 'package:stories_editor/src/domain/models/painting_model.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/gradient_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/painting_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/scroll_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/presentation/bar_tools/main_tools.dart';
import 'package:stories_editor/src/presentation/bar_tools/top_tool_bar.dart';
import 'package:stories_editor/src/presentation/draggable_items/delete_item.dart';
import 'package:stories_editor/src/presentation/draggable_items/draggable_widget.dart';
import 'package:stories_editor/src/presentation/painting_view/painting.dart';
import 'package:stories_editor/src/presentation/painting_view/widgets/sketcher.dart';
import 'package:stories_editor/src/presentation/text_editor_view/TextEditor.dart';
import 'package:stories_editor/src/presentation/utils/constants/app_enums.dart';
import 'package:stories_editor/src/presentation/utils/modal_sheets.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';

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
    this.onRemoveDraggable,
    this.onChatButtonClick,
    this.title,
    this.actions,
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
  final void Function(EditableItem)? onMoveDraggable;

  // item remove callback
  final void Function(String)? onRemoveDraggable;

  // chat button click callback
  final void Function()? onChatButtonClick;

  // top tool bar actions
  final List<Widget>? actions;

  @override
  MainViewState createState() => MainViewState();
}

class MainViewState extends State<MainView> {
  /// content container key
  final GlobalKey contentKey = GlobalKey();

  ///Editable item
  EditableItem? _activeItem;

  /// Gesture Detector listen changes
  Offset _initPos = Offset.zero;
  Offset _currentPos = Offset.zero;
  double _currentScale = 1;
  double _currentRotation = 0;

  /// delete position
  bool _isDeletePosition = false;
  bool _inAction = false;

  Map<String, GlobalKey> draggableKeys = {};

  bool _isInitialValue = false;

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
      child: Material(
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
            return SafeArea(
              top: false,
              child: buildMainView(
                controlNotifier,
                screenUtil,
                colorProvider,
                itemProvider,
                context,
                paintingProvider,
              ),
              // child: ScrollablePageView(
              //   scrollPhysics: controlNotifier.mediaPath.isEmpty &&
              //       itemProvider.draggableWidget.isEmpty &&
              //       !controlNotifier.isPainting &&
              //       !controlNotifier.isTextEditing,
              //   pageController: scrollProvider.pageController,
              //   gridController: scrollProvider.gridController,
              //   mainView: buildMainView(
              //     controlNotifier,
              //     screenUtil,
              //     colorProvider,
              //     itemProvider,
              //     context,
              //     paintingProvider,
              //   ),
              //   gallery: buildGalleryMediaPicker(
              //     scrollProvider,
              //     itemProvider,
              //     controlNotifier,
              //   ),
              // ),
            );
          },
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
    var index = 0;

    return Column(
      children: [
        /// bottom tools
        Expanded(
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
                  controlNotifier.isTextEditing =
                      !controlNotifier.isTextEditing;
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
                          duration: const Duration(milliseconds: 2000),
                          curve: Curves.easeIn,
                          decoration: BoxDecoration(
                            color: _isInitialValue ? Colors.blue : Colors.red,

                            // gradient: controlNotifier.mediaPath.isEmpty
                            //     ? LinearGradient(
                            //         colors: controlNotifier.gradientColors![
                            //             controlNotifier.gradientIndex],
                            //         begin: Alignment.topLeft,
                            //         end: Alignment.bottomRight,
                            //       )
                            //     : LinearGradient(
                            //         colors: [
                            //           colorProvider.color1,
                            //           colorProvider.color2
                            //         ],
                            //         begin: Alignment.topCenter,
                            //         end: Alignment.bottomCenter,
                            //       ),
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

                                widget.centerWidgetBuilder
                                        ?.call(context, screenUtil) ??
                                    const SizedBox(),

                                ///list items
                                ...itemProvider
                                    .getDistinctDraggableWidget()
                                    .toList()
                                    .map((editableItem) {
                                  final draggable = DraggableWidget(
                                    key: _getOrAddKey(editableItem),
                                    context: context,
                                    item: editableItem,
                                    isSelected:
                                        editableItem.id == _activeItem?.id,
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
                                    },
                                    onPointerMove: (details) {
                                      _deletePosition(
                                        editableItem,
                                        details,
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
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 100),
                                    child: OutlinedButton(
                                      child: const Text('Change value'),
                                      onPressed: () {
                                        setState(() {
                                          _isInitialValue = !_isInitialValue;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (!kIsWeb)
                Align(
                  alignment: Alignment.topCenter,
                  child: buildTopToolBar(),
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
            ],
          ),
        ),
      ],
    );
  }

  GlobalKey<State<StatefulWidget>> _getOrAddKey(EditableItem editableItem) {
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
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: TopToolBar(
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
      ),
    );
  }

  GalleryMediaPicker buildGalleryMediaPicker(
    ScrollNotifier scrollProvider,
    DraggableWidgetNotifier itemProvider,
    ControlNotifier controlNotifier,
  ) {
    return GalleryMediaPicker(
      gridViewController: scrollProvider.gridController,
      thumbnailQuality: widget.galleryThumbnailQuality,
      onlyImages: true,
      appBarColor: widget.editorBackgroundColor ?? Colors.black,
      gridViewPhysics: itemProvider.draggableWidget.isEmpty
          ? const NeverScrollableScrollPhysics()
          : const ScrollPhysics(),
      pathList: (path) {
        controlNotifier.mediaPath = path.first.path!;
        if (controlNotifier.mediaPath.isNotEmpty) {
          itemProvider.insert(
            EditableItem()
              ..type = ItemType.image
              ..position = Offset.zero,
          );
        }
        scrollProvider.pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      },
      appBarLeadingWidget: Padding(
        padding: const EdgeInsets.only(bottom: 15, right: 15),
        child: Align(
          alignment: Alignment.bottomRight,
          child: AnimatedOnTapButton(
            onTap: () {
              scrollProvider.pageController.animateToPage(
                0,
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                  width: 1.2,
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

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
    final top = (delta.dy / screenUtil.screenHeight) + _currentPos.dy;

    setState(() {
      _activeItem!.position = Offset(left, top);
      _activeItem!.rotation = details.rotation + _currentRotation;
      _activeItem!.scale = details.scale * _currentScale;
    });
  }

  /// active delete widget with offset position
  void _deletePosition(EditableItem item, PointerMoveEvent details) {
    widget.onMoveDraggable?.call(item);
    if (item.type == ItemType.text &&
        item.position.dy >= 0.75.h &&
        item.position.dx >= -0.4.w &&
        item.position.dx <= 0.2.w) {
      setState(() {
        _isDeletePosition = true;
        item.deletePosition = true;
      });
    } else if (item.type == ItemType.gif &&
        item.position.dy >= 0.62.h &&
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
  void _deleteItemOnCoordinates(EditableItem item, PointerUpEvent details) {
    final itemProvider =
        Provider.of<DraggableWidgetNotifier>(context, listen: false);
    _inAction = false;
    if (item.type == ItemType.image) {
    } else if (item.type == ItemType.text &&
            item.position.dy >= 0.75.h &&
            item.position.dx >= -0.4.w &&
            item.position.dx <= 0.2.w ||
        item.type == ItemType.gif &&
            item.position.dy >= 0.62.h &&
            item.position.dx >= -0.35.w &&
            item.position.dx <= 0.15) {
      setState(() {
        itemProvider.remove(item.id);
        widget.onRemoveDraggable?.call(item.id);
        HapticFeedback.heavyImpact();
      });
    } else {
      itemProvider.onMoveFinish?.call(item);
      setState(() {
        _activeItem = null;
      });
    }
    setState(() {
      _activeItem = null;
    });
  }

  /// update item position, scale, rotation
  void _updateItemPosition(EditableItem item, PointerDownEvent details) {
    if (_inAction) {
      return;
    }

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
          icon: const Icon(
            Icons.navigate_before_rounded,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.navigate_next_rounded,
            color: Colors.white,
            size: 32,
          ),
          onPressed: () {},
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
}
