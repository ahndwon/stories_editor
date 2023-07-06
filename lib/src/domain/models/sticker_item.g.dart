// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FrameSticker _$FrameStickerFromJson(Map<String, dynamic> json) => FrameSticker(
      id: json['id'] as String,
      size:
          const SizeConverter().fromJson(json['size'] as Map<String, dynamic>),
      type: $enumDecode(_$StickerItemTypeEnumMap, json['type']),
      scale: (json['scale'] as num).toDouble(),
    );

Map<String, dynamic> _$FrameStickerToJson(FrameSticker instance) =>
    <String, dynamic>{
      'type': _$StickerItemTypeEnumMap[instance.type]!,
      'id': instance.id,
      'size': const SizeConverter().toJson(instance.size),
      'scale': instance.scale,
    };

const _$StickerItemTypeEnumMap = {
  StickerItemType.frame: 'frame',
  StickerItemType.image: 'image',
  StickerItemType.giphy: 'giphy',
  StickerItemType.text: 'text',
};

ImageSticker _$ImageStickerFromJson(Map<String, dynamic> json) => ImageSticker(
      id: json['id'] as String,
      size:
          const SizeConverter().fromJson(json['size'] as Map<String, dynamic>),
      url: json['url'] as String,
      type: $enumDecode(_$StickerItemTypeEnumMap, json['type']),
      scale: (json['scale'] as num).toDouble(),
    );

Map<String, dynamic> _$ImageStickerToJson(ImageSticker instance) =>
    <String, dynamic>{
      'type': _$StickerItemTypeEnumMap[instance.type]!,
      'id': instance.id,
      'size': const SizeConverter().toJson(instance.size),
      'scale': instance.scale,
      'url': instance.url,
    };

GiphySticker _$GiphyStickerFromJson(Map<String, dynamic> json) => GiphySticker(
      stillUrl: json['stillUrl'] as String?,
      id: json['id'] as String,
      size:
          const SizeConverter().fromJson(json['size'] as Map<String, dynamic>),
      url: json['url'] as String,
      type: $enumDecode(_$StickerItemTypeEnumMap, json['type']),
      scale: (json['scale'] as num).toDouble(),
    );

Map<String, dynamic> _$GiphyStickerToJson(GiphySticker instance) =>
    <String, dynamic>{
      'type': _$StickerItemTypeEnumMap[instance.type]!,
      'id': instance.id,
      'size': const SizeConverter().toJson(instance.size),
      'scale': instance.scale,
      'url': instance.url,
      'stillUrl': instance.stillUrl,
    };

TextSticker _$TextStickerFromJson(Map<String, dynamic> json) => TextSticker(
      id: json['id'] as String,
      size:
          const SizeConverter().fromJson(json['size'] as Map<String, dynamic>),
      text: json['text'] as String,
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16,
      type: $enumDecode(_$StickerItemTypeEnumMap, json['type']),
      scale: (json['scale'] as num).toDouble(),
    );

Map<String, dynamic> _$TextStickerToJson(TextSticker instance) =>
    <String, dynamic>{
      'type': _$StickerItemTypeEnumMap[instance.type]!,
      'id': instance.id,
      'size': const SizeConverter().toJson(instance.size),
      'scale': instance.scale,
      'text': instance.text,
      'fontSize': instance.fontSize,
    };
