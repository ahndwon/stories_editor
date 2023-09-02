// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editing_user.dart';

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

EditingUser _$EditingUserFromJson(Map<String, dynamic> json) => EditingUser(
      id: json['id'] as String,
      username: json['username'] as String,
      backgroundColor:
          const ColorConverter().fromJson(json['backgroundColor'] as String),
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
