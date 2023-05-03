import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:stories_editor/src/domain/converters/color_converter.dart';
import 'package:stories_editor/src/domain/converters/offset_converter.dart';
import 'package:stories_editor/src/presentation/utils/constants/app_enums.dart';
import 'package:uuid/uuid.dart';

part 'editable_items.g.dart';

@JsonSerializable(explicitToJson: true)
class EditableItem implements Comparable<EditableItem> {
  String id = const Uuid().v4();

  /// delete
  bool deletePosition = false;

  /// item position
  @OffsetConverter()
  Offset position = Offset.zero;
  double scale = 1;
  double rotation = 0;
  ItemType type = ItemType.text;

  /// text
  String text = '';
  List<String> textList = [];
  @ColorConverter()
  Color textColor = Colors.transparent;
  TextAlign textAlign = TextAlign.center;
  double fontSize = 20;
  int fontFamily = 0;
  int fontAnimationIndex = 0;
  @ColorConverter()
  Color backGroundColor = Colors.transparent;
  TextAnimationType animationType = TextAnimationType.none;

  /// Gif
  SimpleGiphyGif gif = SimpleGiphyGif(id: '0', url: '', stillUrl: '');

  static EditableItem fromJson(Map<String, dynamic> value) =>
      _$EditableItemFromJson(value);

  Map<String, dynamic> toJson() => _$EditableItemToJson(this);

  @override
  int compareTo(EditableItem other) => other.id.compareTo(id);
}

@JsonSerializable()
class SimpleGiphyGif {
  SimpleGiphyGif({
    required this.id,
    required this.url,
    required this.stillUrl,
  });

  final String id;
  final String url;
  final String stillUrl;

  static SimpleGiphyGif fromJson(Map<String, dynamic> value) =>
      _$SimpleGiphyGifFromJson(value);

  Map<String, dynamic> toJson() => _$SimpleGiphyGifToJson(this);
}
