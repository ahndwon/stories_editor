// ignore_for_file: must_be_immutable
library stories_editor;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/models/editable_items.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/gradient_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/painting_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/scroll_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/presentation/main_view/main_view.dart';

export 'package:stories_editor/src/domain/models/editable_items.dart';
export 'package:stories_editor/src/domain/models/painting_model.dart';
export 'package:stories_editor/src/domain/providers/notifiers/control_provider.dart';
export 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
export 'package:stories_editor/src/domain/providers/notifiers/painting_notifier.dart';
export 'package:stories_editor/src/presentation/utils/constants/app_enums.dart';
export 'package:stories_editor/src/presentation/utils/screen_util_helper.dart';
export 'package:stories_editor/stories_editor.dart';

class StoriesEditor extends StatefulWidget {
  const StoriesEditor({
    super.key,
    required this.giphyKey,
    required this.onDone,
    this.middleBottomWidget,
    this.centerWidgetBuilder,
    this.colorList,
    this.gradientColors,
    this.fontFamilyList,
    this.isCustomFontList,
    this.onBackPress,
    this.onDoneButtonStyle,
    this.editorBackgroundColor,
    this.galleryThumbnailQuality,
    this.controlController,
    this.scrollController,
    this.draggableWidgetController,
    this.gradientController,
    this.paintingController,
    this.textEditingController,
    this.onAddDraggable,
    this.onMoveDraggable,
    this.onMoveEndDraggable,
    this.onRemoveDraggable,
    this.onChatButtonClick,
    this.actions,
    this.title,
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

  /// on done
  final void Function(String)? onDone;

  /// on done button Text
  final Widget? onDoneButtonStyle;

  /// on back pressed
  final Future<bool>? onBackPress;

  /// editor custom color palette list
  final List<Color>? colorList;

  /// editor background color
  final Color? editorBackgroundColor;

  /// gallery thumbnail quality
  final int? galleryThumbnailQuality;

  // top tool bar actions
  final List<Widget>? actions;

  // widget for title
  final Widget? title;

  // undo button click callback
  final void Function()? onUndo;

  // redo button click callback
  final void Function()? onRedo;

  final ControlNotifier? controlController;
  final ScrollNotifier? scrollController;
  final DraggableWidgetNotifier? draggableWidgetController;
  final GradientNotifier? gradientController;
  final PaintingNotifier? paintingController;
  final TextEditingNotifier? textEditingController;
  final void Function(EditableItem)? onAddDraggable;
  final void Function(EditableItem)? onMoveDraggable;
  final void Function(EditableItem)? onMoveEndDraggable;
  final void Function(String)? onRemoveDraggable;
  final void Function()? onChatButtonClick;

  /// center widget
  final Widget Function(BuildContext context, ScreenUtil screenUtil)?
      centerWidgetBuilder;

  @override
  StoriesEditorState createState() => StoriesEditorState();
}

class StoriesEditorState extends State<StoriesEditor> {
  @override
  void initState() {
    Paint.enableDithering = true;
    WidgetsFlutterBinding.ensureInitialized();
    // SystemChrome.setPreferredOrientations(
    //   [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    // );
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      super.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final draggableWidgetNotifier = (widget.draggableWidgetController ??
        DraggableWidgetNotifier())
      ..onAddDraggable = widget.onAddDraggable;
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowIndicator();
        return false;
      },
      child: ScreenUtilInit(
        designSize: const Size(1080, 1920),
        // designSize: const Size(960, 1280),
        builder: (_, __) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => widget.controlController ?? ControlNotifier(),
            ),
            ChangeNotifierProvider(
              create: (_) => widget.scrollController ?? ScrollNotifier(),
            ),
            ChangeNotifierProvider(
              create: (_) => draggableWidgetNotifier,
            ),
            ChangeNotifierProvider(
              create: (_) => widget.gradientController ?? GradientNotifier(),
            ),
            ChangeNotifierProvider(
              create: (_) => widget.paintingController ?? PaintingNotifier(),
            ),
            ChangeNotifierProvider(
              create: (_) =>
                  widget.textEditingController ?? TextEditingNotifier(),
            ),
          ],
          child: MainView(
            giphyKey: widget.giphyKey,
            onDone: widget.onDone,
            fontFamilyList: widget.fontFamilyList,
            isCustomFontList: widget.isCustomFontList,
            middleBottomWidget: widget.middleBottomWidget,
            centerWidgetBuilder: widget.centerWidgetBuilder,
            gradientColors: widget.gradientColors,
            colorList: widget.colorList,
            onDoneButtonStyle: widget.onDoneButtonStyle,
            onBackPress: widget.onBackPress,
            editorBackgroundColor: widget.editorBackgroundColor,
            galleryThumbnailQuality: widget.galleryThumbnailQuality,
            onMoveDraggable: widget.onMoveDraggable,
            onMoveEndDraggable: widget.onMoveEndDraggable,
            onRemoveDraggable: widget.onRemoveDraggable,
            onChatButtonClick: widget.onChatButtonClick,
            actions: widget.actions,
            title: widget.title,
            onUndo: widget.onUndo,
            onRedo: widget.onRedo,
          ),
        ),
      ),
    );
  }
}
