import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:modal_gif_picker/modal_gif_picker.dart';
import 'package:stories_editor/src/domain/models/editable_items.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';

class DraggableWidgetNotifier extends ChangeNotifier {
  List<StickerItem> _draggableWidget = [];

  List<StickerItem> get draggableWidget => _draggableWidget;
  void Function(StickerItem)? onAddDraggable;

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
}
