import 'package:flutter/material.dart';
import 'package:modal_gif_picker/modal_gif_picker.dart';
import 'package:stories_editor/src/domain/models/editable_items.dart';

class DraggableWidgetNotifier extends ChangeNotifier {
  List<EditableItem> _draggableWidget = [];

  List<EditableItem> get draggableWidget => _draggableWidget;
  void Function(EditableItem)? onAddDraggable;

  set draggableWidget(List<EditableItem> item) {
    _draggableWidget = item;
    notifyListeners();
  }

  GiphyGif? _gif;

  GiphyGif? get giphy => _gif;

  void Function(EditableItem item)? onMoveFinish;

  // set giphy(GiphyGif? giphy) {
  //   _gif = giphy;
  //   notifyListeners();
  // }

  void insert(EditableItem item, {int index = 0, bool silent = false}) {
    _draggableWidget.insert(index, item);
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
}
