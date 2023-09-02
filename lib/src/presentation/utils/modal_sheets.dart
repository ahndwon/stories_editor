import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_gif_picker/modal_gif_picker.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';
import 'package:stories_editor/src/domain/providers/notifiers/control_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/draggable_widget_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/painting_notifier.dart';
import 'package:stories_editor/src/domain/providers/notifiers/text_editing_notifier.dart';
import 'package:stories_editor/src/domain/sevices/save_as_image.dart';
import 'package:stories_editor/src/presentation/utils/Extensions/hexColor.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';

/// create item of type GIF
Future<void> createGiphyItem({
  required BuildContext context,
  required String giphyKey,
}) async {
  final editableItem =
      Provider.of<DraggableWidgetNotifier>(context, listen: false);
  final giphy = await ModalGifPicker.pickModalSheetGif(
    context: context,
    apiKey: giphyKey,
    rating: GiphyRating.r,
    sticker: true,
    backDropColor: Colors.black,
    crossAxisCount: 3,
    childAspectRatio: 1.2,
    topDragColor: Colors.white.withOpacity(0.2),
  );

  /// create item of type GIF
  if (giphy != null) {
    editableItem.insert(GiphySticker(
      id: giphy.id,
      url: giphy.images.original?.url ?? '',
      stillUrl: giphy.images.originalStill?.url ?? '',
    )
        // ..type = ItemType.gif
        // ..gif = SimpleGiphyGif(
        //   id: giphy.id,
        //   url: giphy.images.original?.url ?? '',
        //   stillUrl: giphy.images.originalStill?.url ?? '',
        // )
        // ..position = Offset.zero,
        );
    // editableItem.giphy = giphy;
  }
}

/// custom exit dialog
Future<bool> exitDialog({
  required BuildContext context,
  required Key contentKey,
}) async {
  return (await showDialog<bool>(
        context: context,
        barrierColor: Colors.black38,
        builder: (c) => Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetAnimationDuration: const Duration(milliseconds: 300),
          insetAnimationCurve: Curves.ease,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Container(
              padding: const EdgeInsets.only(
                top: 25,
                bottom: 5,
                right: 20,
                left: 20,
              ),
              alignment: Alignment.center,
              height: 280,
              decoration: BoxDecoration(
                color: HexColor.fromHex('#262626'),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.white10,
                    offset: Offset(0, 1),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Discard Edits?',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "If you go back now, you'll lose all the edits you've made.",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white54,
                      letterSpacing: 0.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 40,
                  ),

                  /// discard
                  AnimatedOnTapButton(
                    onTap: () async {
                      _resetDefaults(context: context);
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      'Discard',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.redAccent.shade200,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.1,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                    child: Divider(
                      color: Colors.white10,
                    ),
                  ),

                  /// save and exit
                  AnimatedOnTapButton(
                    onTap: () async {
                      final paintingProvider =
                          Provider.of<PaintingNotifier>(context, listen: false);
                      final widgetProvider =
                          Provider.of<DraggableWidgetNotifier>(
                        context,
                        listen: false,
                      );
                      if (paintingProvider.lines.isNotEmpty ||
                          widgetProvider.draggableWidget.isNotEmpty) {
                        /// save image
                        final response = await takePicture(
                          contentKey: contentKey,
                          context: context,
                          saveToGallery: true,
                        );
                        if (response == true) {
                          _dispose(
                            context: context,
                            message: 'Successfully saved',
                          );
                        } else {
                          _dispose(context: context, message: 'Error');
                        }
                      } else {
                        _dispose(context: context, message: 'Draft Empty');
                      }
                    },
                    child: const Text(
                      'Save Draft',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 22,
                    child: Divider(
                      color: Colors.white10,
                    ),
                  ),

                  ///cancel
                  AnimatedOnTapButton(
                    onTap: () {
                      Navigator.of(context).pop(false);
                    },
                    child: const Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )) ??
      false;
}

void _resetDefaults({required BuildContext context}) {
  final paintingProvider =
      Provider.of<PaintingNotifier>(context, listen: false);
  final widgetProvider =
      Provider.of<DraggableWidgetNotifier>(context, listen: false);
  final controlProvider = Provider.of<ControlNotifier>(context, listen: false);
  final editingProvider =
      Provider.of<TextEditingNotifier>(context, listen: false);
  if (paintingProvider.lines.isNotEmpty) {
    paintingProvider.lines.clear();
  }
  if (widgetProvider.draggableWidget.isNotEmpty) {
    widgetProvider.draggableWidget.clear();
  }
  widgetProvider.setDefaults();
  paintingProvider.resetDefaults();
  editingProvider.setDefaults();
  controlProvider.mediaPath = '';
}

void _dispose({required BuildContext context, required String message}) {
  _resetDefaults(context: context);
  Fluttertoast.showToast(msg: message);
  Navigator.of(context).pop(true);
}
