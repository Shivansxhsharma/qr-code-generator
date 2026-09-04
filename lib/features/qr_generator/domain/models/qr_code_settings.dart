import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeSettings {
  const QrCodeSettings({
    this.content = '',
    this.foregroundColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.size = 220,
    this.padding = 12,
    this.errorCorrectionLevel = QrErrorCorrectLevel.M,
    this.logoImage,
  });

  final String content;
  final Color foregroundColor;
  final Color backgroundColor;
  final double size;
  final double padding;
  final int errorCorrectionLevel;
  final File? logoImage;

  bool get hasContent => content.trim().isNotEmpty;

  QrCodeSettings copyWith({
    String? content,
    Color? foregroundColor,
    Color? backgroundColor,
    double? size,
    double? padding,
    int? errorCorrectionLevel,
    File? logoImage,
    bool clearLogo = false,
  }) {
    return QrCodeSettings(
      content: content ?? this.content,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      size: size ?? this.size,
      padding: padding ?? this.padding,
      errorCorrectionLevel: errorCorrectionLevel ?? this.errorCorrectionLevel,
      logoImage: clearLogo ? null : (logoImage ?? this.logoImage),
    );
  }
}
