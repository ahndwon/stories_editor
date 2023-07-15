import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_editor_plus/image_editor_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stories_editor/src/presentation/widgets/rotate_interactive_viewer.dart';
import 'package:stories_editor/src/presentation/widgets/unnotifiable_transformation_controller.dart';

class CutImage extends StatefulWidget {
  const CutImage({
    super.key,
    required this.controller,
    this.width = 100,
    this.height = 100,
    this.onAddContent,
    this.imageUrl,
    this.onInteractionEnd,
  });

  final UnNotifiableTransformationController controller;
  final double width;
  final double height;
  final String? imageUrl;
  final void Function(XFile, Matrix4)? onAddContent;
  final void Function(Matrix4)? onInteractionEnd;

  @override
  State<CutImage> createState() => _CutImageState();
}

class _CutImageState extends State<CutImage> {
  XFile? imageFile;
  String? imageUrl;
  bool isImageChanged = false;

  // bool isImageEditMode = false;

  @override
  Widget build(BuildContext context) {
    Widget child = const Icon(Icons.add);
    Widget image;
    if (widget.imageUrl != null &&
        (widget.imageUrl?.isNotEmpty ?? false) &&
        !isImageChanged) {
      image = Image.network(widget.imageUrl!);
    } else if (imageFile != null) {
      image = Image.file(File(imageFile!.path));
    } else {
      image = const SizedBox();
    }
    child = RotateInteractiveViewer(
      transformationController: widget.controller,
      maxScale: 10,
      minScale: 0.3,
      onInteractionEnd: (ScaleEndDetails details) {
        widget.onInteractionEnd?.call(widget.controller.value);
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        color: Colors.red,
        child: Center(
          // child: Image.file(File(imageFile!.path), fit: BoxFit.fitWidth),
          child: image,
        ),
      ),
    );
    return GestureDetector(
      // onDoubleTap: () {
      //   setState(() {
      //     isImageEditMode = !isImageEditMode;
      //   });
      // },
      onTap: () async {
        final imageFile = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxHeight: 600,
          maxWidth: 600,
        );
        if (imageFile == null) return;
        widget.controller.value = Matrix4.identity();
        final data = await imageFile.readAsBytes();
        // ignore: use_build_context_synchronously
        final newImageData = await Navigator.push(
          context,
          // ignore: inference_failure_on_instance_creation
          MaterialPageRoute(
            builder: (context) => ImageEditor(
              image: data,
              appBar: Colors.blue,
            ),
          ),
        );
        // if (editedImage == null) return;
        // if (editedImage.savePath == null) return;
        final directory = await getTemporaryDirectory();
        final savePath = '${directory.path}/${imageFile.name}';
        final newImage = XFile.fromData(
          newImageData as Uint8List,
          path: savePath,
        );
        await newImage.saveTo(savePath);
        widget.onAddContent?.call(newImage, widget.controller.value);
        setState(() {
          this.imageFile = newImage;
          isImageChanged = true;
        });
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: child,
        // child: IgnorePointer(ignoring: !isImageEditMode, child: child),
        // child: IgnorePointer(ignoring: !isImageEditMode, child: child),
        // child: child,
      ),
    );
  }
}

class CutImageController {
  CutImageController({
    this.imageFile,
    required this.index,
  });

  final XFile? imageFile;
  final int index;
}
