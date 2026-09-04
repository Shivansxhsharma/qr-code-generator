import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/models/qr_history_entry.dart';
import '../../../../core/repositories/qr_history_repository.dart';
import '../../domain/models/qr_code_settings.dart';

class QrGeneratorProvider extends ChangeNotifier {
  QrCodeSettings _settings = const QrCodeSettings();
  final ImagePicker _imagePicker = ImagePicker();
  QrHistoryRepository? _historyRepository;

  QrCodeSettings get settings => _settings;

  void attachHistoryRepository(QrHistoryRepository repository) {
    _historyRepository ??= repository;
  }

  void updateContent(String content) {
    _settings = _settings.copyWith(content: content);
    notifyListeners();
  }

  void updateForegroundColor(Color color) {
    _settings = _settings.copyWith(foregroundColor: color);
    notifyListeners();
  }

  void updateBackgroundColor(Color color) {
    _settings = _settings.copyWith(backgroundColor: color);
    notifyListeners();
  }

  void updateSize(double size) {
    _settings = _settings.copyWith(size: size);
    notifyListeners();
  }

  void updatePadding(double padding) {
    _settings = _settings.copyWith(padding: padding);
    notifyListeners();
  }

  void updateErrorCorrectionLevel(int level) {
    _settings = _settings.copyWith(errorCorrectionLevel: level);
    notifyListeners();
  }

  Future<bool> pickLogoImage() async {
    final XFile? picked = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (picked == null) {
      return false;
    }

    _settings = _settings.copyWith(logoImage: File(picked.path));
    notifyListeners();
    return true;
  }

  void clearLogoImage() {
    _settings = _settings.copyWith(clearLogo: true);
    notifyListeners();
  }

  Future<void> saveToHistory() async {
    if (!_settings.hasContent || _historyRepository == null) {
      return;
    }

    await _historyRepository!.add(
      QrHistoryEntry(
        content: _settings.content.trim(),
        createdAt: DateTime.now(),
      ),
    );
  }
}
