import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stories_editor/src/domain/converters/matrix4_converter.dart';
import 'package:stories_editor/src/domain/models/editing_user.dart';

part 'cut_content_info.g.dart';

@CopyWith()
@JsonSerializable(explicitToJson: true)
class CutContentInfo {
  const CutContentInfo({
    this.type = ContentType.image,
    required this.contentPath,
    this.width = 200,
    this.height = 200,
    required this.matrix4,
    this.editingUser,
  });

  const CutContentInfo.empty({ContentType contentType = ContentType.image})
      : contentPath = '',
        type = contentType,
        width = 200,
        height = 200,
        editingUser = null,
        matrix4 = null;

  final String contentPath;
  final ContentType type;
  final int width;
  final int height;
  @Matrix4Converter()
  final Matrix4? matrix4;
  final EditingUser? editingUser;

  static CutContentInfo fromJson(Map<String, dynamic> value) =>
      _$CutContentInfoFromJson(value);

  Map<String, dynamic> toJson() => _$CutContentInfoToJson(this);
}

enum ContentType { image, video }
