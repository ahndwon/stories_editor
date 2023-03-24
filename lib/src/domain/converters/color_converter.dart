import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class ColorConverter implements JsonConverter<Color, String> {
  const ColorConverter();

  @override
  Color fromJson(String value) => Color(int.parse(value));

  @override
  String toJson(Color value) => value.toString();
}
