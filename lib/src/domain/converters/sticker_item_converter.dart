import 'package:json_annotation/json_annotation.dart';
import 'package:stories_editor/src/domain/models/sticker_item.dart';

class StickerItemConverter
    implements JsonConverter<StickerItem, Map<String, dynamic>> {
  const StickerItemConverter();

  @override
  StickerItem fromJson(Map<String, dynamic> json) {
    final jsonType = json['type'];
    if (jsonType == StickerItemType.image.name) {
      return ImageSticker.fromJson(json);
    } else if (jsonType == StickerItemType.frame.name) {
      return FrameSticker.fromJson(json);
    } else if (jsonType == StickerItemType.giphy.name) {
      return GiphySticker.fromJson(json);
    } else if (jsonType == StickerItemType.text.name) {
      return TextSticker.fromJson(json);
    } else {
      throw StateError('StickerItemType fromJson not implemented : $jsonType');
    }
  }

  @override
  Map<String, dynamic> toJson(StickerItem value) {
    if (value is ImageSticker) {
      return value.toJson();
    } else if (value is FrameSticker) {
      return value.toJson();
    } else if (value is GiphySticker) {
      return value.toJson();
    } else if (value is TextSticker) {
      return value.toJson();
    } else {
      throw StateError(
        'StickerItemType toJson not implemented : ${value.type}',
      );
    }
  }
}
