import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/history/data/repositories/in_memory_qr_history_repository.dart';
import 'features/qr_generator/presentation/pages/qr_generator_page.dart';
import 'features/qr_generator/presentation/providers/qr_generator_provider.dart';

class QrCodeGeneratorApp extends StatelessWidget {
  const QrCodeGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => InMemoryQrHistoryRepository()),
        ChangeNotifierProxyProvider<InMemoryQrHistoryRepository,
            QrGeneratorProvider>(
          create: (_) => QrGeneratorProvider(),
          update: (_, repository, provider) {
            final resolvedProvider = provider ?? QrGeneratorProvider();
            resolvedProvider.attachHistoryRepository(repository);
            return resolvedProvider;
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Code Generator',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.indigo,
        ),
        home: const QrGeneratorPage(),
      ),
    );
  }
}
