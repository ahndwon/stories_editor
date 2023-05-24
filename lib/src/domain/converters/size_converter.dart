import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class SizeConverter implements JsonConverter<Size, Map<String, dynamic>> {
  const SizeConverter();

  @override
  Size fromJson(Map<String, dynamic> json) => Size(
        json['width'] as double? ?? 0,
        json['height'] as double? ?? 0,
      );

  @override
  Map<String, dynamic> toJson(Size value) => {
        'width': value.width,
        'height': value.height,
      };
}
