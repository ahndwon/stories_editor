// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editable_items.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$EditingUserCWProxy {
  EditingUser id(String id);

  EditingUser username(String username);

  EditingUser backgroundColor(Color backgroundColor);

  EditingUser receivedAt(DateTime? receivedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EditingUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EditingUser(...).copyWith(id: 12, name: "My name")
  /// ````
  EditingUser call({
    String? id,
    String? username,
    Color? backgroundColor,
    DateTime? receivedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfEditingUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfEditingUser.copyWith.fieldName(...)`
class _$EditingUserCWProxyImpl implements _$EditingUserCWProxy {
  const _$EditingUserCWProxyImpl(this._value);

  final EditingUser _value;

  @override
  EditingUser id(String id) => this(id: id);

  @override
  EditingUser username(String username) => this(username: username);

  @override
  EditingUser backgroundColor(Color backgroundColor) =>
      this(backgroundColor: backgroundColor);

  @override
  EditingUser receivedAt(DateTime? receivedAt) => this(receivedAt: receivedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `EditingUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// EditingUser(...).copyWith(id: 12, name: "My name")
  /// ````
  EditingUser call({
    Object? id = const $CopyWithPlaceholder(),
    Object? username = const $CopyWithPlaceholder(),
    Object? backgroundColor = const $CopyWithPlaceholder(),
    Object? receivedAt = const $CopyWithPlaceholder(),
  }) {
    return EditingUser(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String,
      username: username == const $CopyWithPlaceholder() || username == null
          ? _value.username
          // ignore: cast_nullable_to_non_nullable
          : username as String,
      backgroundColor: backgroundColor == const $CopyWithPlaceholder() ||
              backgroundColor == null
          ? _value.backgroundColor
          // ignore: cast_nullable_to_non_nullable
          : backgroundColor as Color,
      receivedAt: receivedAt == const $CopyWithPlaceholder()
          ? _value.receivedAt
          // ignore: cast_nullable_to_non_nullable
          : receivedAt as DateTime?,
    );
  }
}

extension $EditingUserCopyWith on EditingUser {
  /// Returns a callable class that can be used as follows: `instanceOfEditingUser.copyWith(...)` or like so:`instanceOfEditingUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$EditingUserCWProxy get copyWith => _$EditingUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EditableItem _$EditableItemFromJson(Map<String, dynamic> json) => EditableItem()
  ..id = json['id'] as String
  ..deletePosition = json['deletePosition'] as bool
  ..position =
      const OffsetConverter().fromJson(json['position'] as Map<String, dynamic>)
  ..scale = (json['scale'] as num).toDouble()
  ..rotation = (json['rotation'] as num).toDouble()
  ..type = $enumDecode(_$ItemTypeEnumMap, json['type'])
  ..imageUrl = json['imageUrl'] as String?
  ..text = json['text'] as String
  ..textList =
      (json['textList'] as List<dynamic>).map((e) => e as String).toList()
  ..textColor = const ColorConverter().fromJson(json['textColor'] as int)
  ..textAlign = $enumDecode(_$TextAlignEnumMap, json['textAlign'])
  ..fontSize = (json['fontSize'] as num).toDouble()
  ..fontFamily = json['fontFamily'] as int
  ..fontAnimationIndex = json['fontAnimationIndex'] as int
  ..backGroundColor =
      const ColorConverter().fromJson(json['backGroundColor'] as int)
  ..animationType =
      $enumDecode(_$TextAnimationTypeEnumMap, json['animationType'])
  ..editingUser = json['editingUser'] == null
      ? null
      : EditingUser.fromJson(json['editingUser'] as Map<String, dynamic>)
  ..isFlip = json['isFlip'] as bool? ?? false
  ..gif = SimpleGiphyGif.fromJson(json['gif'] as Map<String, dynamic>);

Map<String, dynamic> _$EditableItemToJson(EditableItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'deletePosition': instance.deletePosition,
      'position': const OffsetConverter().toJson(instance.position),
      'scale': instance.scale,
      'rotation': instance.rotation,
      'type': _$ItemTypeEnumMap[instance.type]!,
      'imageUrl': instance.imageUrl,
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
      'editingUser': instance.editingUser?.toJson(),
      'isFlip': instance.isFlip,
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

EditingUser _$EditingUserFromJson(Map<String, dynamic> json) => EditingUser(
      id: json['id'] as String,
      username: json['username'] as String,
      backgroundColor:
          const ColorConverter().fromJson(json['backgroundColor'] as int),
      receivedAt: _$JsonConverterFromJson<String, DateTime>(
          json['receivedAt'], const DateTimeConverter().fromJson),
    );

Map<String, dynamic> _$EditingUserToJson(EditingUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'backgroundColor':
          const ColorConverter().toJson(instance.backgroundColor),
      'receivedAt': _$JsonConverterToJson<String, DateTime>(
          instance.receivedAt, const DateTimeConverter().toJson),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);
