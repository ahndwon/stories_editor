import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gallery_media_picker/gallery_media_picker.dart';
import 'package:provider/provider.dart';
import 'package:stories_editor/src/domain/sevices/save_as_image.dart';
import 'package:stories_editor/src/presentation/utils/modal_sheets.dart';
import 'package:stories_editor/src/presentation/widgets/animated_onTap_button.dart';
import 'package:stories_editor/src/presentation/widgets/tool_button.dart';
import 'package:stories_editor/stories_editor.dart';

class MainTools extends StatefulWidget {
  const MainTools({super.key, required this.contentKey, required this.context});

  final GlobalKey contentKey;
  final BuildContext context;

  @override
  MainToolsState createState() => MainToolsState();
}

class MainToolsState extends State<MainTools> {
  @override
  Widget build(BuildContext context) {
    return Consumer3<ControlNotifier, PaintingNotifier,
        DraggableWidgetNotifier>(
      builder: (_, controlNotifier, paintingNotifier, itemNotifier, __) {
        return Container(
          height: 60,
          padding: EdgeInsets.symmetric(vertical: 20.w),
          decoration: const BoxDecoration(color: Colors.transparent),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              /// close button
              ToolButton(
                backGroundColor: Colors.black12,
                onTap: () async {
                  final res = await exitDialog(
                    context: widget.context,
                    contentKey: widget.contentKey,
                  );
                  if (res) {
                    Navigator.pop(context);
                  }
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              if (controlNotifier.mediaPath.isEmpty)
                _selectColor(
                  controlProvider: controlNotifier,
                  onTap: () {
                    if (controlNotifier.gradientIndex >=
                        controlNotifier.gradientColors!.length - 1) {
                      setState(() {
                        controlNotifier.gradientIndex = 0;
                      });
                    } else {
                      setState(() {
                        controlNotifier.gradientIndex += 1;
                      });
                    }
                  },
                ),
              ToolButton(
                backGroundColor: Colors.black12,
                onTap: () async {
                  if (paintingNotifier.lines.isNotEmpty ||
                      itemNotifier.draggableWidget.isNotEmpty) {
                    final response = await takePicture(
                      contentKey: widget.contentKey,
                      context: context,
                      saveToGallery: true,
                    );
                    if (response == true) {
                      await Fluttertoast.showToast(msg: 'Successfully saved');
                    } else {
                      await Fluttertoast.showToast(msg: 'Error');
                    }
                  }
                },
                child: const ImageIcon(
                  AssetImage(
                    'assets/icons/download.png',
                    package: 'stories_editor',
                  ),
                  color: Colors.white,
                  size: 20,
                ),
              ),
              ToolButton(
                backGroundColor: Colors.black12,
                onTap: () => createGiphyItem(
                  context: context,
                  giphyKey: controlNotifier.giphyKey,
                ),
                child: const ImageIcon(
                  AssetImage(
                    'assets/icons/stickers.png',
                    package: 'stories_editor',
                  ),
                  color: Colors.white,
                  size: 20,
                ),
              ),
              ToolButton(
                backGroundColor: Colors.black12,
                onTap: () {
                  controlNotifier.isPainting = true;
                  //createLinePainting(context: context);
                },
                child: const ImageIcon(
                  AssetImage(
                    'assets/icons/draw.png',
                    package: 'stories_editor',
                  ),
                  color: Colors.white,
                  size: 20,
                ),
              ),
              // ToolButton(
              //   child: ImageIcon(
              //     const AssetImage('assets/icons/photo_filter.png',
              //         package: 'stories_editor'),
              //     color: controlNotifier.isPhotoFilter ? Colors.black : Colors.white,
              //     size: 20,
              //   ),
              //   backGroundColor:  controlNotifier.isPhotoFilter ? Colors.white70 : Colors.black12,
              //   onTap: () => controlNotifier.isPhotoFilter =
              //   !controlNotifier.isPhotoFilter,
              // ),
              ToolButton(
                backGroundColor: Colors.black12,
                onTap: () => controlNotifier.isTextEditing =
                    !controlNotifier.isTextEditing,
                child: const ImageIcon(
                  AssetImage(
                    'assets/icons/text.png',
                    package: 'stories_editor',
                  ),
                  color: Colors.white,
                  size: 20,
                ),
              ),
              ToolButton(
                backGroundColor: Colors.black12,
                onTap: () async {
                  await showModalBottomSheet<void>(
                    context: context,
                    builder: (context) {
                      return buildGalleryMediaPicker(
                        itemNotifier,
                        controlNotifier,
                      );
                    },
                  );
                },
                child: const ImageIcon(
                  AssetImage(
                    'assets/icons/photo_filter.png',
                    package: 'stories_editor',
                  ),
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     /// close button
          //     ToolButton(
          //       backGroundColor: Colors.black12,
          //       onTap: () async {
          //         final res = await exitDialog(
          //           context: widget.context,
          //           contentKey: widget.contentKey,
          //         );
          //         if (res) {
          //           Navigator.pop(context);
          //         }
          //       },
          //       child: const Icon(
          //         Icons.close,
          //         color: Colors.white,
          //       ),
          //     ),
          //     if (controlNotifier.mediaPath.isEmpty)
          //       _selectColor(
          //         controlProvider: controlNotifier,
          //         onTap: () {
          //           if (controlNotifier.gradientIndex >=
          //               controlNotifier.gradientColors!.length - 1) {
          //             setState(() {
          //               controlNotifier.gradientIndex = 0;
          //             });
          //           } else {
          //             setState(() {
          //               controlNotifier.gradientIndex += 1;
          //             });
          //           }
          //         },
          //       ),
          //     ToolButton(
          //       backGroundColor: Colors.black12,
          //       onTap: () async {
          //         if (paintingNotifier.lines.isNotEmpty ||
          //             itemNotifier.draggableWidget.isNotEmpty) {
          //           final response = await takePicture(
          //             contentKey: widget.contentKey,
          //             context: context,
          //             saveToGallery: true,
          //           );
          //           if (response == true) {
          //             await Fluttertoast.showToast(msg: 'Successfully saved');
          //           } else {
          //             await Fluttertoast.showToast(msg: 'Error');
          //           }
          //         }
          //       },
          //       child: const ImageIcon(
          //         AssetImage(
          //           'assets/icons/download.png',
          //           package: 'stories_editor',
          //         ),
          //         color: Colors.white,
          //         size: 20,
          //       ),
          //     ),
          //     ToolButton(
          //       backGroundColor: Colors.black12,
          //       onTap: () => createGiphyItem(
          //         context: context,
          //         giphyKey: controlNotifier.giphyKey,
          //       ),
          //       child: const ImageIcon(
          //         AssetImage(
          //           'assets/icons/stickers.png',
          //           package: 'stories_editor',
          //         ),
          //         color: Colors.white,
          //         size: 20,
          //       ),
          //     ),
          //     ToolButton(
          //       backGroundColor: Colors.black12,
          //       onTap: () {
          //         controlNotifier.isPainting = true;
          //         //createLinePainting(context: context);
          //       },
          //       child: const ImageIcon(
          //         AssetImage(
          //           'assets/icons/draw.png',
          //           package: 'stories_editor',
          //         ),
          //         color: Colors.white,
          //         size: 20,
          //       ),
          //     ),
          //     // ToolButton(
          //     //   child: ImageIcon(
          //     //     const AssetImage('assets/icons/photo_filter.png',
          //     //         package: 'stories_editor'),
          //     //     color: controlNotifier.isPhotoFilter ? Colors.black : Colors.white,
          //     //     size: 20,
          //     //   ),
          //     //   backGroundColor:  controlNotifier.isPhotoFilter ? Colors.white70 : Colors.black12,
          //     //   onTap: () => controlNotifier.isPhotoFilter =
          //     //   !controlNotifier.isPhotoFilter,
          //     // ),
          //     ToolButton(
          //       backGroundColor: Colors.black12,
          //       onTap: () => controlNotifier.isTextEditing =
          //           !controlNotifier.isTextEditing,
          //       child: const ImageIcon(
          //         AssetImage(
          //           'assets/icons/text.png',
          //           package: 'stories_editor',
          //         ),
          //         color: Colors.white,
          //         size: 20,
          //       ),
          //     ),
          //   ],
          // ),
        );
      },
    );
  }

  GalleryMediaPicker buildGalleryMediaPicker(
    DraggableWidgetNotifier itemProvider,
    ControlNotifier controlNotifier,
  ) {
    return GalleryMediaPicker(
      gridViewController: ScrollController(),
      thumbnailQuality: 300,
      onlyImages: true,
      appBarColor: Colors.black,
      gridViewPhysics: itemProvider.draggableWidget.isEmpty
          ? const NeverScrollableScrollPhysics()
          : const ScrollPhysics(),
      pathList: (path) {
        controlNotifier.mediaPath = path.first.path!;
        if (controlNotifier.mediaPath.isNotEmpty) {
          itemProvider.insert(
            EditableItem()
              ..imageUrl = path.first.path!
              ..type = ItemType.image
              ..position = Offset.zero,
          );
        }
        Navigator.of(context).pop();
      },
      appBarLeadingWidget: Padding(
        padding: const EdgeInsets.only(bottom: 15, right: 15),
        child: Align(
          alignment: Alignment.bottomRight,
          child: AnimatedOnTapButton(
            onTap: () {},
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

  /// gradient color selector
  Widget _selectColor({
    void Function()? onTap,
    required ControlNotifier controlProvider,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 8),
      child: AnimatedOnTapButton(
        onTap: () => onTap?.call(),
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: controlProvider
                    .gradientColors![controlProvider.gradientIndex],
              ),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
