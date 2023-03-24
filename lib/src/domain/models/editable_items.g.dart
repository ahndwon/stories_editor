// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editable_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditableItem _$EditableItemFromJson(Map<String, dynamic> json) => EditableItem()
  ..deletePosition = json['deletePosition'] as bool
  ..position =
      const OffsetConverter().fromJson(json['position'] as Map<String, dynamic>)
  ..scale = (json['scale'] as num).toDouble()
  ..rotation = (json['rotation'] as num).toDouble()
  ..type = $enumDecode(_$ItemTypeEnumMap, json['type'])
  ..text = json['text'] as String
  ..textList =
      (json['textList'] as List<dynamic>).map((e) => e as String).toList()
  ..textColor = const ColorConverter().fromJson(json['textColor'] as String)
  ..textAlign = $enumDecode(_$TextAlignEnumMap, json['textAlign'])
  ..fontSize = (json['fontSize'] as num).toDouble()
  ..fontFamily = json['fontFamily'] as int
  ..fontAnimationIndex = json['fontAnimationIndex'] as int
  ..backGroundColor =
      const ColorConverter().fromJson(json['backGroundColor'] as String)
  ..animationType =
      $enumDecode(_$TextAnimationTypeEnumMap, json['animationType'])
  ..gif = SimpleGiphyGif.fromJson(json['gif'] as Map<String, dynamic>);

Map<String, dynamic> _$EditableItemToJson(EditableItem instance) =>
    <String, dynamic>{
      'deletePosition': instance.deletePosition,
      'position': const OffsetConverter().toJson(instance.position),
      'scale': instance.scale,
      'rotation': instance.rotation,
      'type': _$ItemTypeEnumMap[instance.type]!,
      'text': instance.text,
      'textList': instance.textList,
      'textColor': const ColorConverter().toJson(instance.textColor),
      'textAlign': _$TextAlignEnumMap[instance.textAlign]!,
      'fontSize': instance.fontSize,
      'fontFamily': instance.fontFamily,
      'fontAnimationIndex': instance.fontAnimationIndex,
      'backGroundColor':
          const ColorConverter().toJson(instance.backGroundColor),
      'animationType': _$TextAnimationTypeEnumMap[instance.animationType]!,
      'gif': instance.gif.toJson(),
    };

const _$ItemTypeEnumMap = {
  ItemType.image: 'image',
  ItemType.text: 'text',
  ItemType.video: 'video',
  ItemType.gif: 'gif',
};

const _$TextAlignEnumMap = {
  TextAlign.left: 'left',
  TextAlign.right: 'right',
  TextAlign.center: 'center',
  TextAlign.justify: 'justify',
  TextAlign.start: 'start',
  TextAlign.end: 'end',
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

SimpleGiphyGif _$SimpleGiphyGifFromJson(Map<String, dynamic> json) =>
    SimpleGiphyGif(
      id: json['id'] as String,
      url: json['url'] as String,
      stillUrl: json['stillUrl'] as String,
    );

Map<String, dynamic> _$SimpleGiphyGifToJson(SimpleGiphyGif instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'stillUrl': instance.stillUrl,
    };
