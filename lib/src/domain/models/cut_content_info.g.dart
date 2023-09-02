// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cut_content_info.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CutContentInfoCWProxy {
  CutContentInfo type(ContentType type);

  CutContentInfo contentPath(String contentPath);

  CutContentInfo width(int width);

  CutContentInfo height(int height);

  CutContentInfo matrix4(Matrix4? matrix4);

  CutContentInfo editingUser(EditingUser? editingUser);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CutContentInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CutContentInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  CutContentInfo call({
    ContentType? type,
    String? contentPath,
    int? width,
    int? height,
    Matrix4? matrix4,
    EditingUser? editingUser,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfCutContentInfo.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfCutContentInfo.copyWith.fieldName(...)`
class _$CutContentInfoCWProxyImpl implements _$CutContentInfoCWProxy {
  const _$CutContentInfoCWProxyImpl(this._value);

  final CutContentInfo _value;

  @override
  CutContentInfo type(ContentType type) => this(type: type);

  @override
  CutContentInfo contentPath(String contentPath) =>
      this(contentPath: contentPath);

  @override
  CutContentInfo width(int width) => this(width: width);

  @override
  CutContentInfo height(int height) => this(height: height);

  @override
  CutContentInfo matrix4(Matrix4? matrix4) => this(matrix4: matrix4);

  @override
  CutContentInfo editingUser(EditingUser? editingUser) =>
      this(editingUser: editingUser);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `CutContentInfo(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// CutContentInfo(...).copyWith(id: 12, name: "My name")
  /// ````
  CutContentInfo call({
    Object? type = const $CopyWithPlaceholder(),
    Object? contentPath = const $CopyWithPlaceholder(),
    Object? width = const $CopyWithPlaceholder(),
    Object? height = const $CopyWithPlaceholder(),
    Object? matrix4 = const $CopyWithPlaceholder(),
    Object? editingUser = const $CopyWithPlaceholder(),
  }) {
    return CutContentInfo(
      type: type == const $CopyWithPlaceholder() || type == null
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as ContentType,
      contentPath:
          contentPath == const $CopyWithPlaceholder() || contentPath == null
              ? _value.contentPath
              // ignore: cast_nullable_to_non_nullable
              : contentPath as String,
      width: width == const $CopyWithPlaceholder() || width == null
          ? _value.width
          // ignore: cast_nullable_to_non_nullable
          : width as int,
      height: height == const $CopyWithPlaceholder() || height == null
          ? _value.height
          // ignore: cast_nullable_to_non_nullable
          : height as int,
      matrix4: matrix4 == const $CopyWithPlaceholder()
          ? _value.matrix4
          // ignore: cast_nullable_to_non_nullable
          : matrix4 as Matrix4?,
      editingUser: editingUser == const $CopyWithPlaceholder()
          ? _value.editingUser
          // ignore: cast_nullable_to_non_nullable
          : editingUser as EditingUser?,
    );
  }
}

extension $CutContentInfoCopyWith on CutContentInfo {
  /// Returns a callable class that can be used as follows: `instanceOfCutContentInfo.copyWith(...)` or like so:`instanceOfCutContentInfo.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CutContentInfoCWProxy get copyWith => _$CutContentInfoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CutContentInfo _$CutContentInfoFromJson(Map<String, dynamic> json) =>
    CutContentInfo(
      type: $enumDecodeNullable(_$ContentTypeEnumMap, json['type']) ??
          ContentType.image,
      contentPath: json['contentPath'] as String,
      width: json['width'] as int? ?? 200,
      height: json['height'] as int? ?? 200,
      matrix4: _$JsonConverterFromJson<List<dynamic>, Matrix4>(
          json['matrix4'], const Matrix4Converter().fromJson),
      editingUser: json['editingUser'] == null
          ? null
          : EditingUser.fromJson(json['editingUser'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CutContentInfoToJson(CutContentInfo instance) =>
    <String, dynamic>{
      'contentPath': instance.contentPath,
      'type': _$ContentTypeEnumMap[instance.type]!,
      'width': instance.width,
      'height': instance.height,
      'matrix4': _$JsonConverterToJson<List<dynamic>, Matrix4>(
          instance.matrix4, const Matrix4Converter().toJson),
      'editingUser': instance.editingUser?.toJson(),
    };

const _$ContentTypeEnumMap = {
  ContentType.image: 'image',
  ContentType.video: 'video',
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
