import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../providers/qr_generator_provider.dart';
import '../widgets/color_selector.dart';
import '../widgets/error_correction_selector.dart';

class QrGeneratorPage extends StatefulWidget {
  const QrGeneratorPage({super.key});

  @override
  State<QrGeneratorPage> createState() => _QrGeneratorPageState();
}

class _QrGeneratorPageState extends State<QrGeneratorPage> {
  final TextEditingController _contentController = TextEditingController();

  @override
  void dispose() {
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<QrGeneratorProvider>();
    final settings = provider.settings;

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Generator'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                key: const Key('qr-content-input'),
                controller: _contentController,
                decoration: const InputDecoration(
                  labelText: 'Text or URL',
                  hintText: 'Enter value to encode',
                  border: OutlineInputBorder(),
                ),
                onChanged: provider.updateContent,
              ),
              const SizedBox(height: 16),
              Center(
                child: Container(
                  padding: EdgeInsets.all(settings.padding),
                  color: settings.backgroundColor,
                  child: settings.hasContent
                      ? QrImageView(
                          key: const Key('qr-preview'),
                          data: settings.content,
                          version: QrVersions.auto,
                          size: settings.size,
                          gapless: false,
                          errorCorrectionLevel: settings.errorCorrectionLevel,
                          backgroundColor: settings.backgroundColor,
                          dataModuleStyle: QrDataModuleStyle(
                            color: settings.foregroundColor,
                            dataModuleShape: QrDataModuleShape.square,
                          ),
                          eyeStyle: QrEyeStyle(
                            color: settings.foregroundColor,
                            eyeShape: QrEyeShape.square,
                          ),
                          embeddedImage: settings.logoImage != null
                              ? FileImage(settings.logoImage!)
                              : null,
                          embeddedImageStyle: const QrEmbeddedImageStyle(
                            size: Size(40, 40),
                          ),
                        )
                      : SizedBox(
                          width: settings.size,
                          height: settings.size,
                          child: Center(
                            child: Text(
                              'Preview appears here',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 20),
              ErrorCorrectionSelector(
                selectedLevel: settings.errorCorrectionLevel,
                onChanged: provider.updateErrorCorrectionLevel,
              ),
              const SizedBox(height: 16),
              ColorSelector(
                title: 'Foreground color',
                selectedColor: settings.foregroundColor,
                onColorSelected: provider.updateForegroundColor,
              ),
              const SizedBox(height: 16),
              ColorSelector(
                title: 'Background color',
                selectedColor: settings.backgroundColor,
                onColorSelected: provider.updateBackgroundColor,
              ),
              const SizedBox(height: 16),
              Text('QR size: ${settings.size.toStringAsFixed(0)} px'),
              Slider(
                value: settings.size,
                min: 120,
                max: 360,
                divisions: 24,
                onChanged: provider.updateSize,
              ),
              Text('Padding: ${settings.padding.toStringAsFixed(0)} px'),
              Slider(
                value: settings.padding,
                min: 0,
                max: 32,
                divisions: 16,
                onChanged: provider.updatePadding,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  FilledButton.icon(
                    onPressed: () async {
                      final picked = await provider.pickLogoImage();
                      if (!context.mounted) {
                        return;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            picked
                                ? 'Logo image added to QR code'
                                : 'No image selected',
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.image_outlined),
                    label: const Text('Add logo'),
                  ),
                  OutlinedButton.icon(
                    onPressed: settings.logoImage == null
                        ? null
                        : provider.clearLogoImage,
                    icon: const Icon(Icons.image_not_supported_outlined),
                    label: const Text('Remove logo'),
                  ),
                  OutlinedButton.icon(
                    onPressed: settings.hasContent
                        ? () async {
                            await provider.saveToHistory();
                            if (!context.mounted) {
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Saved to local history'),
                              ),
                            );
                          }
                        : null,
                    icon: const Icon(Icons.history),
                    label: const Text('Save history'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
