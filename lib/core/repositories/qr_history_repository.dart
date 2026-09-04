import '../models/qr_history_entry.dart';

abstract class QrHistoryRepository {
  Future<void> add(QrHistoryEntry entry);
  Future<List<QrHistoryEntry>> getAll();
}
