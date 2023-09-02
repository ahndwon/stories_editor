// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sticker_item.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CutStickerCWProxy {
  CutSticker id(String id);

  CutSticker content(CutContentInfo content);

  CutSticker type(StickerItemType type);

  CutSticker scale(double scale);

  CutSticker size(Size size);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CutSticker(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CutSticker(...).copyWith(id: 12, name: "My name")
  /// ````
  CutSticker call({
    String? id,
    CutContentInfo? content,
    StickerItemType? type,
    double? scale,
    Size? size,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCutSticker.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCutSticker.copyWith.fieldName(...)`
class _$CutStickerCWProxyImpl implements _$CutStickerCWProxy {
  const _$CutStickerCWProxyImpl(this._value);

  final CutSticker _value;

  @override
  CutSticker id(String id) => this(id: id);

  @override
  CutSticker content(CutContentInfo content) => this(content: content);

  @override
  CutSticker type(StickerItemType type) => this(type: type);

  @override
  CutSticker scale(double scale) => this(scale: scale);

  @override
  CutSticker size(Size size) => this(size: size);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CutSticker(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CutSticker(...).copyWith(id: 12, name: "My name")
  /// ````
  CutSticker call({
    Object? id = const $CopyWithPlaceholder(),
    Object? content = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? scale = const $CopyWithPlaceholder(),
    Object? size = const $CopyWithPlaceholder(),
  }) {
    return CutSticker(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      content: content == const $CopyWithPlaceholder() || content == null
          ? _value.content
          // ignore: cast_nullable_to_non_nullable
          : content as CutContentInfo,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as StickerItemType,
      scale: scale == const $CopyWithPlaceholder() || scale == null
          ? _value.scale
          // ignore: cast_nullable_to_non_nullable
          : scale as double,
      size: size == const $CopyWithPlaceholder() || size == null
          ? _value.size
          // ignore: cast_nullable_to_non_nullable
          : size as Size,
    );
  }
}

extension $CutStickerCopyWith on CutSticker {
  /// Returns a callable class that can be used as follows: `instanceOfCutSticker.copyWith(...)` or like so:`instanceOfCutSticker.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CutStickerCWProxy get copyWith => _$CutStickerCWProxyImpl(this);
}

abstract class _$ImageStickerCWProxy {
  ImageSticker id(String id);

  ImageSticker url(String url);

  ImageSticker size(Size size);

  ImageSticker type(StickerItemType type);

  ImageSticker scale(double scale);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ImageSticker(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ImageSticker(...).copyWith(id: 12, name: "My name")
  /// ````
  ImageSticker call({
    String? id,
    String? url,
    Size? size,
    StickerItemType? type,
    double? scale,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfImageSticker.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfImageSticker.copyWith.fieldName(...)`
class _$ImageStickerCWProxyImpl implements _$ImageStickerCWProxy {
  const _$ImageStickerCWProxyImpl(this._value);

  final ImageSticker _value;

  @override
  ImageSticker id(String id) => this(id: id);

  @override
  ImageSticker url(String url) => this(url: url);

  @override
  ImageSticker size(Size size) => this(size: size);

  @override
  ImageSticker type(StickerItemType type) => this(type: type);

  @override
  ImageSticker scale(double scale) => this(scale: scale);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ImageSticker(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ImageSticker(...).copyWith(id: 12, name: "My name")
  /// ````
  ImageSticker call({
    Object? id = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? size = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? scale = const $CopyWithPlaceholder(),
  }) {
    return ImageSticker(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      url: url == const $CopyWithPlaceholder() || url == null
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      size: size == const $CopyWithPlaceholder() || size == null
          ? _value.size
          // ignore: cast_nullable_to_non_nullable
          : size as Size,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as StickerItemType,
      scale: scale == const $CopyWithPlaceholder() || scale == null
          ? _value.scale
          // ignore: cast_nullable_to_non_nullable
          : scale as double,
    );
  }
}

extension $ImageStickerCopyWith on ImageSticker {
  /// Returns a callable class that can be used as follows: `instanceOfImageSticker.copyWith(...)` or like so:`instanceOfImageSticker.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ImageStickerCWProxy get copyWith => _$ImageStickerCWProxyImpl(this);
}

abstract class _$GiphyStickerCWProxy {
  GiphySticker stillUrl(String? stillUrl);

  GiphySticker id(String id);

  GiphySticker url(String url);

  GiphySticker size(Size size);

  GiphySticker type(StickerItemType type);

  GiphySticker scale(double scale);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GiphySticker(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GiphySticker(...).copyWith(id: 12, name: "My name")
  /// ````
  GiphySticker call({
    String? stillUrl,
    String? id,
    String? url,
    Size? size,
    StickerItemType? type,
    double? scale,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfGiphySticker.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfGiphySticker.copyWith.fieldName(...)`
class _$GiphyStickerCWProxyImpl implements _$GiphyStickerCWProxy {
  const _$GiphyStickerCWProxyImpl(this._value);

  final GiphySticker _value;

  @override
  GiphySticker stillUrl(String? stillUrl) => this(stillUrl: stillUrl);

  @override
  GiphySticker id(String id) => this(id: id);

  @override
  GiphySticker url(String url) => this(url: url);

  @override
  GiphySticker size(Size size) => this(size: size);

  @override
  GiphySticker type(StickerItemType type) => this(type: type);

  @override
  GiphySticker scale(double scale) => this(scale: scale);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `GiphySticker(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// GiphySticker(...).copyWith(id: 12, name: "My name")
  /// ````
  GiphySticker call({
    Object? stillUrl = const $CopyWithPlaceholder(),
    Object? id = const $CopyWithPlaceholder(),
    Object? url = const $CopyWithPlaceholder(),
    Object? size = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? scale = const $CopyWithPlaceholder(),
  }) {
    return GiphySticker(
      stillUrl: stillUrl == const $CopyWithPlaceholder()
          ? _value.stillUrl
          // ignore: cast_nullable_to_non_nullable
          : stillUrl as String?,
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      url: url == const $CopyWithPlaceholder() || url == null
          ? _value.url
          // ignore: cast_nullable_to_non_nullable
          : url as String,
      size: size == const $CopyWithPlaceholder() || size == null
          ? _value.size
          // ignore: cast_nullable_to_non_nullable
          : size as Size,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as StickerItemType,
      scale: scale == const $CopyWithPlaceholder() || scale == null
          ? _value.scale
          // ignore: cast_nullable_to_non_nullable
          : scale as double,
    );
  }
}

extension $GiphyStickerCopyWith on GiphySticker {
  /// Returns a callable class that can be used as follows: `instanceOfGiphySticker.copyWith(...)` or like so:`instanceOfGiphySticker.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$GiphyStickerCWProxy get copyWith => _$GiphyStickerCWProxyImpl(this);
}

abstract class _$TextStickerCWProxy {
  TextSticker id(String id);

  TextSticker text(String text);

  TextSticker size(Size size);

  TextSticker fontSize(double fontSize);

  TextSticker type(StickerItemType type);

  TextSticker scale(double scale);

  TextSticker textList(List<String> textList);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TextSticker(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TextSticker(...).copyWith(id: 12, name: "My name")
  /// ````
  TextSticker call({
    String? id,
    String? text,
    Size? size,
    double? fontSize,
    StickerItemType? type,
    double? scale,
    List<String>? textList,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTextSticker.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTextSticker.copyWith.fieldName(...)`
class _$TextStickerCWProxyImpl implements _$TextStickerCWProxy {
  const _$TextStickerCWProxyImpl(this._value);

  final TextSticker _value;

  @override
  TextSticker id(String id) => this(id: id);

  @override
  TextSticker text(String text) => this(text: text);

  @override
  TextSticker size(Size size) => this(size: size);

  @override
  TextSticker fontSize(double fontSize) => this(fontSize: fontSize);

  @override
  TextSticker type(StickerItemType type) => this(type: type);

  @override
  TextSticker scale(double scale) => this(scale: scale);

  @override
  TextSticker textList(List<String> textList) => this(textList: textList);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TextSticker(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TextSticker(...).copyWith(id: 12, name: "My name")
  /// ````
  TextSticker call({
    Object? id = const $CopyWithPlaceholder(),
    Object? text = const $CopyWithPlaceholder(),
    Object? size = const $CopyWithPlaceholder(),
    Object? fontSize = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? scale = const $CopyWithPlaceholder(),
    Object? textList = const $CopyWithPlaceholder(),
  }) {
    return TextSticker(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      text: text == const $CopyWithPlaceholder() || text == null
          ? _value.text
          // ignore: cast_nullable_to_non_nullable
          : text as String,
      size: size == const $CopyWithPlaceholder() || size == null
          ? _value.size
          // ignore: cast_nullable_to_non_nullable
          : size as Size,
      fontSize: fontSize == const $CopyWithPlaceholder() || fontSize == null
          ? _value.fontSize
          // ignore: cast_nullable_to_non_nullable
          : fontSize as double,
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as StickerItemType,
      scale: scale == const $CopyWithPlaceholder() || scale == null
          ? _value.scale
          // ignore: cast_nullable_to_non_nullable
          : scale as double,
      textList: textList == const $CopyWithPlaceholder() || textList == null
          ? _value.textList
          // ignore: cast_nullable_to_non_nullable
          : textList as List<String>,
    );
  }
}

extension $TextStickerCopyWith on TextSticker {
  /// Returns a callable class that can be used as follows: `instanceOfTextSticker.copyWith(...)` or like so:`instanceOfTextSticker.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TextStickerCWProxy get copyWith => _$TextStickerCWProxyImpl(this);
}

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
      content: json['content'] == null
          ? const CutContentInfo.empty()
          : CutContentInfo.fromJson(json['content'] as Map<String, dynamic>),
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
      'content': instance.content.toJson(),
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
          const ColorConverter().fromJson(json['backGroundColor'] as String)
      ..animationType =
          $enumDecode(_$TextAnimationTypeEnumMap, json['animationType'])
      ..textColor = const ColorConverter().fromJson(json['textColor'] as String)
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
