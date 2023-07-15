// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// StickerItem _$StickerItemFromJson(Map<String, dynamic> json) => StickerItem(
//       id: json['id'] as String,
//       type: $enumDecode(_$StickerItemTypeEnumMap, json['type']),
//       size: json['size'] == null
//           ? const Size(200, 200)
//           : const SizeConverter()
//               .fromJson(json['size'] as Map<String, dynamic>),
//       scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
//       rotation: (json['rotation'] as num?)?.toDouble() ?? 0,
//       position: json['position'] == null
//           ? Offset.zero
//           : const OffsetConverter()
//               .fromJson(json['position'] as Map<String, dynamic>),
//     )
//       ..isFlip = json['isFlip'] as bool
//       ..editingUser = json['editingUser'] == null
//           ? null
//           : EditingUser.fromJson(json['editingUser'] as Map<String, dynamic>)
//       ..deletePosition = json['deletePosition'] as bool;

Map<String, dynamic> _$StickerItemToJson(StickerItem instance) =>
    <String, dynamic>{
      'type': _$StickerItemTypeEnumMap[instance.type]!,
      'id': instance.id,
      'size': const SizeConverter().toJson(instance.size),
      'scale': instance.scale,
      'rotation': instance.rotation,
      'position': const OffsetConverter().toJson(instance.position),
      'isFlip': instance.isFlip,
      'editingUser': instance.editingUser?.toJson(),
      'deletePosition': instance.deletePosition,
    };

const _$StickerItemTypeEnumMap = {
  StickerItemType.cut: 'cut',
  StickerItemType.image: 'image',
  StickerItemType.giphy: 'giphy',
  StickerItemType.text: 'text',
};

CutSticker _$CutStickerFromJson(Map<String, dynamic> json) => CutSticker(
      id: json['id'] as String,
      url: json['url'] as String,
      type: $enumDecodeNullable(_$StickerItemTypeEnumMap, json['type']) ??
          StickerItemType.cut,
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      size: json['size'] == null
          ? const Size(200, 200)
          : const SizeConverter()
              .fromJson(json['size'] as Map<String, dynamic>),
    )
      ..rotation = (json['rotation'] as num).toDouble()
      ..position = const OffsetConverter()
          .fromJson(json['position'] as Map<String, dynamic>)
      ..isFlip = json['isFlip'] as bool
      ..editingUser = json['editingUser'] == null
          ? null
          : EditingUser.fromJson(json['editingUser'] as Map<String, dynamic>)
      ..deletePosition = json['deletePosition'] as bool;

Map<String, dynamic> _$CutStickerToJson(CutSticker instance) =>
    <String, dynamic>{
      'type': _$StickerItemTypeEnumMap[instance.type]!,
      'id': instance.id,
      'size': const SizeConverter().toJson(instance.size),
      'scale': instance.scale,
      'rotation': instance.rotation,
      'position': const OffsetConverter().toJson(instance.position),
      'isFlip': instance.isFlip,
      'editingUser': instance.editingUser?.toJson(),
      'deletePosition': instance.deletePosition,
      'url': instance.url,
    };

ImageSticker _$ImageStickerFromJson(Map<String, dynamic> json) => ImageSticker(
      id: json['id'] as String,
      url: json['url'] as String,
      size: json['size'] == null
          ? const Size(200, 200)
          : const SizeConverter()
              .fromJson(json['size'] as Map<String, dynamic>),
      type: $enumDecodeNullable(_$StickerItemTypeEnumMap, json['type']) ??
          StickerItemType.image,
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
    )
      ..rotation = (json['rotation'] as num).toDouble()
      ..position = const OffsetConverter()
          .fromJson(json['position'] as Map<String, dynamic>)
      ..isFlip = json['isFlip'] as bool
      ..editingUser = json['editingUser'] == null
          ? null
          : EditingUser.fromJson(json['editingUser'] as Map<String, dynamic>)
      ..deletePosition = json['deletePosition'] as bool;

Map<String, dynamic> _$ImageStickerToJson(ImageSticker instance) =>
    <String, dynamic>{
      'type': _$StickerItemTypeEnumMap[instance.type]!,
      'id': instance.id,
      'size': const SizeConverter().toJson(instance.size),
      'scale': instance.scale,
      'rotation': instance.rotation,
      'position': const OffsetConverter().toJson(instance.position),
      'isFlip': instance.isFlip,
      'editingUser': instance.editingUser?.toJson(),
      'deletePosition': instance.deletePosition,
      'url': instance.url,
    };

GiphySticker _$GiphyStickerFromJson(Map<String, dynamic> json) => GiphySticker(
      stillUrl: json['stillUrl'] as String?,
      id: json['id'] as String,
      url: json['url'] as String,
      size: json['size'] == null
          ? const Size(200, 200)
          : const SizeConverter()
              .fromJson(json['size'] as Map<String, dynamic>),
      type: $enumDecodeNullable(_$StickerItemTypeEnumMap, json['type']) ??
          StickerItemType.giphy,
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
    )
      ..rotation = (json['rotation'] as num).toDouble()
      ..position = const OffsetConverter()
          .fromJson(json['position'] as Map<String, dynamic>)
      ..isFlip = json['isFlip'] as bool
      ..editingUser = json['editingUser'] == null
          ? null
          : EditingUser.fromJson(json['editingUser'] as Map<String, dynamic>)
      ..deletePosition = json['deletePosition'] as bool;

Map<String, dynamic> _$GiphyStickerToJson(GiphySticker instance) =>
    <String, dynamic>{
      'type': _$StickerItemTypeEnumMap[instance.type]!,
      'id': instance.id,
      'size': const SizeConverter().toJson(instance.size),
      'scale': instance.scale,
      'rotation': instance.rotation,
      'position': const OffsetConverter().toJson(instance.position),
      'isFlip': instance.isFlip,
      'editingUser': instance.editingUser?.toJson(),
      'deletePosition': instance.deletePosition,
      'url': instance.url,
      'stillUrl': instance.stillUrl,
    };

TextSticker _$TextStickerFromJson(Map<String, dynamic> json) => TextSticker(
      id: json['id'] as String,
      text: json['text'] as String,
      size: json['size'] == null
          ? const Size(200, 200)
          : const SizeConverter()
              .fromJson(json['size'] as Map<String, dynamic>),
      fontSize: (json['fontSize'] as num?)?.toDouble() ?? 16,
      type: $enumDecodeNullable(_$StickerItemTypeEnumMap, json['type']) ??
          StickerItemType.text,
      scale: (json['scale'] as num?)?.toDouble() ?? 1.0,
      textList: (json['textList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    )
      ..rotation = (json['rotation'] as num).toDouble()
      ..position = const OffsetConverter()
          .fromJson(json['position'] as Map<String, dynamic>)
      ..isFlip = json['isFlip'] as bool
      ..editingUser = json['editingUser'] == null
          ? null
          : EditingUser.fromJson(json['editingUser'] as Map<String, dynamic>)
      ..deletePosition = json['deletePosition'] as bool
      ..backGroundColor =
          const ColorConverter().fromJson(json['backGroundColor'] as int)
      ..animationType =
          $enumDecode(_$TextAnimationTypeEnumMap, json['animationType'])
      ..textColor = const ColorConverter().fromJson(json['textColor'] as int)
      ..textAlign = $enumDecode(_$TextAlignEnumMap, json['textAlign'])
      ..fontFamily = json['fontFamily'] as int
      ..fontAnimationIndex = json['fontAnimationIndex'] as int;

Map<String, dynamic> _$TextStickerToJson(TextSticker instance) =>
    <String, dynamic>{
      'type': _$StickerItemTypeEnumMap[instance.type]!,
      'id': instance.id,
      'size': const SizeConverter().toJson(instance.size),
      'scale': instance.scale,
      'rotation': instance.rotation,
      'position': const OffsetConverter().toJson(instance.position),
      'isFlip': instance.isFlip,
      'editingUser': instance.editingUser?.toJson(),
      'deletePosition': instance.deletePosition,
      'text': instance.text,
      'textList': instance.textList,
      'fontSize': instance.fontSize,
      'backGroundColor':
          const ColorConverter().toJson(instance.backGroundColor),
      'animationType': _$TextAnimationTypeEnumMap[instance.animationType]!,
      'textColor': const ColorConverter().toJson(instance.textColor),
      'textAlign': _$TextAlignEnumMap[instance.textAlign]!,
      'fontFamily': instance.fontFamily,
      'fontAnimationIndex': instance.fontAnimationIndex,
    };

const _$TextAnimationTypeEnumMap = {
  TextAnimationType.none: 'none',
  TextAnimationType.fade: 'fade',
  TextAnimationType.typer: 'typer',
  TextAnimationType.typeWriter: 'typeWriter',
  TextAnimationType.scale: 'scale',
  TextAnimationType.colorize: 'colorize',
  TextAnimationType.wavy: 'wavy',
  TextAnimationType.flicker: 'flicker',
};

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
};
