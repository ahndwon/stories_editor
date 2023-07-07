import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stories_editor/src/domain/converters/color_converter.dart';
import 'package:stories_editor/src/domain/converters/offset_converter.dart';
import 'package:stories_editor/src/domain/converters/size_converter.dart';
import 'package:stories_editor/src/domain/converters/sticker_item_converter.dart';
import 'package:stories_editor/stories_editor.dart';

part 'sticker_item.g.dart';

@JsonSerializable(explicitToJson: true)
sealed class StickerItem implements Comparable<StickerItem> {
  StickerItem({
    required this.id,
    required this.type,
    this.size = const Size(200, 200),
    this.scale = 1.0,
    this.rotation = 0,
    this.position = Offset.zero,
  });

  final StickerItemType type;
  final String id;
  @SizeConverter()
  final Size size;
  double scale;
  double rotation;
  @OffsetConverter()
  Offset position = Offset.zero;
  bool isFlip = false;
  EditingUser? editingUser;
  bool deletePosition = false;

  Map<String, dynamic> toJson() => const StickerItemConverter().toJson(this);

  static StickerItem fromJson(Map<String, dynamic> json) =>
      const StickerItemConverter().fromJson(json);

  @override
  int compareTo(StickerItem other) => other.id.compareTo(id);

  @override
  String toString() => toJson().toString();
}

@JsonSerializable(explicitToJson: true)
class FrameSticker extends StickerItem {
  FrameSticker({
    required super.id,
    super.type = StickerItemType.frame,
    super.scale = 1.0,
    super.size = const Size(200, 200),
  });

  @override
  Map<String, dynamic> toJson() => _$FrameStickerToJson(this);

  static FrameSticker fromJson(Map<String, dynamic> json) =>
      _$FrameStickerFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class ImageSticker extends StickerItem {
  ImageSticker({
    required super.id,
    required this.url,
    super.size = const Size(200, 200),
    super.type = StickerItemType.image,
    super.scale = 1.0,
  });

  String url;

  @override
  Map<String, dynamic> toJson() => _$ImageStickerToJson(this);

  static ImageSticker fromJson(Map<String, dynamic> json) =>
      _$ImageStickerFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class GiphySticker extends StickerItem {
  GiphySticker({
    this.stillUrl,
    required super.id,
    required this.url,
    super.size = const Size(200, 200),
    super.type = StickerItemType.giphy,
    super.scale = 1.0,
  });

  final String url;
  final String? stillUrl;

  @override
  Map<String, dynamic> toJson() => _$GiphyStickerToJson(this);

  static GiphySticker fromJson(Map<String, dynamic> json) =>
      _$GiphyStickerFromJson(json);
}

@JsonSerializable(explicitToJson: true)
class TextSticker extends StickerItem {
  TextSticker({
    required super.id,
    required this.text,
    super.size = const Size(200, 200),
    this.fontSize = 16,
    super.type = StickerItemType.text,
    super.scale,
    this.textList = const [],
  });

  final String text;
  final List<String> textList;
  final double fontSize;
  @ColorConverter()
  Color backGroundColor = Colors.transparent;
  TextAnimationType animationType = TextAnimationType.none;
  @ColorConverter()
  Color textColor = Colors.transparent;
  TextAlign textAlign = TextAlign.center;
  int fontFamily = 0;
  int fontAnimationIndex = 0;

  @override
  Map<String, dynamic> toJson() => _$TextStickerToJson(this);

  static TextSticker fromJson(Map<String, dynamic> json) =>
      _$TextStickerFromJson(json);
}

enum StickerItemType {
  frame,
  image,
  giphy,
  text;
}
