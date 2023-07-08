import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stories_editor/src/domain/converters/color_converter.dart';
import 'package:stories_editor/src/domain/converters/datetime_converter.dart';

part 'editing_user.g.dart';

@CopyWith()
@ColorConverter()
@DateTimeConverter()
@JsonSerializable(explicitToJson: true)
class EditingUser {
  EditingUser({
    required this.id,
    required this.username,
    required this.backgroundColor,
    this.receivedAt,
  });

  final String id;
  final String username;
  final Color backgroundColor;
  final DateTime? receivedAt;

  static EditingUser fromJson(Map<String, dynamic> value) =>
      _$EditingUserFromJson(value);

  Map<String, dynamic> toJson() => _$EditingUserToJson(this);
}
