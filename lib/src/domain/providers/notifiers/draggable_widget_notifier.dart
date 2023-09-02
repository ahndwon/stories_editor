import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:modal_gif_picker/modal_gif_picker.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';
import 'package:stories_editor/src/presentation/widgets/unnotifiable_transformation_controller.dart';

class DraggableWidgetNotifier extends ChangeNotifier {
  List<StickerItem> _draggableWidget = [];

  List<StickerItem> get draggableWidget => _draggableWidget;

  HashMap<String, UnNotifiableTransformationController> transformerControllers =
      HashMap();

  void Function(StickerItem)? onAddDraggable;

  void Function(String cutId, Matrix4 matrix4)? onCutTransform;

  set draggableWidget(List<StickerItem> item) {
    _draggableWidget = item;
    notifyListeners();
  }

  GiphyGif? _gif;

  GiphyGif? get giphy => _gif;

  // set giphy(GiphyGif? giphy) {
  //   _gif = giphy;
  //   notifyListeners();
  // }

  void insert(StickerItem item, {int index = 0, bool silent = false}) {
    if (_draggableWidget.where((d) => d.id == item.id).isNotEmpty) {
      return;
    }
    if (_draggableWidget.isEmpty) {
      _draggableWidget = [item];
    } else {
      _draggableWidget.insert(index, item);
    }
    if (!silent) {
      onAddDraggable?.call(item);
    }
    notifyListeners();
  }

  UnNotifiableTransformationController createTransformerController({
    required String id,
    Matrix4? matrix4,
  }) {
    final controller = UnNotifiableTransformationController();
    if (matrix4 != null) {
      controller.value = matrix4;
    }
    transformerControllers[id] = controller
      ..addListener(() {
        onCutTransform?.call(id, transformerControllers[id]!.value);
      });

    return controller;
  }

  void remove(String itemId) {
    _draggableWidget.removeWhere((element) => element.id == itemId);
    notifyListeners();
  }

  void setDefaults() {
    _draggableWidget = [];
  }

  Set<StickerItem> getDistinctDraggableWidget() {
    var newDraggableWidget = <StickerItem>{};
    if (draggableWidget.isNotEmpty) {
      newDraggableWidget = SplayTreeSet<StickerItem>.from(draggableWidget);
    }
    return newDraggableWidget;
  }

  int? cutStickerIndex(String id) {
    var i = 0;

    for (final d in draggableWidget) {
      if (d.type == StickerItemType.cut) {
        if (d.id == id) {
          return i;
        } else {
          i++;
        }
      }
    }
    return null;
  }

  void clear() {
    transformerControllers.forEach((key, value) => value.dispose());
    onCutTransform = null;
    onAddDraggable = null;
  }
}
