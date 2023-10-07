import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

class SizeConverter implements JsonConverter<Size, Map<String, dynamic>> {
  const SizeConverter();

  @override
  Size fromJson(Map<String, dynamic> json) {
    final width = json['width'] ?? '0';
    final height = json['height'] ?? '0';
    return Size(
      double.parse(width.toString()),
      double.parse(height.toString()),
    );
  }

  @override
  Map<String, dynamic> toJson(Size value) => {
        'width': value.width,
        'height': value.height,
      };
}
