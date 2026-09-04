import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:qr_code_generator/features/history/data/repositories/in_memory_qr_history_repository.dart';
import 'package:qr_code_generator/features/qr_generator/presentation/pages/qr_generator_page.dart';
import 'package:qr_code_generator/features/qr_generator/presentation/providers/qr_generator_provider.dart';

Widget _buildTestApp() {
  return MultiProvider(
    providers: [
      Provider(create: (_) => InMemoryQrHistoryRepository()),
      ChangeNotifierProxyProvider<InMemoryQrHistoryRepository, QrGeneratorProvider>(
        create: (_) => QrGeneratorProvider(),
        update: (_, repository, provider) {
          final resolved = provider ?? QrGeneratorProvider();
          resolved.attachHistoryRepository(repository);
          return resolved;
        },
      ),
    ],
    child: const MaterialApp(home: QrGeneratorPage()),
  );
}

void main() {
  testWidgets('shows QR preview when content is entered', (tester) async {
    await tester.pumpWidget(_buildTestApp());

    expect(find.text('Preview appears here'), findsOneWidget);
    expect(find.byKey(const Key('qr-preview')), findsNothing);

    await tester.enterText(
      find.byKey(const Key('qr-content-input')),
      'https://example.com',
    );
    await tester.pump();

    expect(find.byKey(const Key('qr-preview')), findsOneWidget);
  });

  testWidgets('size slider updates visible label', (tester) async {
    await tester.pumpWidget(_buildTestApp());

    expect(find.text('QR size: 220 px'), findsOneWidget);

    final slider = find.byType(Slider).first;
    await tester.drag(slider, const Offset(220, 0));
    await tester.pumpAndSettle();

    expect(find.textContaining('QR size:'), findsOneWidget);
    expect(find.text('QR size: 220 px'), findsNothing);
  });
}
