import '../../../../core/models/qr_history_entry.dart';
import '../../../../core/repositories/qr_history_repository.dart';

class InMemoryQrHistoryRepository implements QrHistoryRepository {
  final List<QrHistoryEntry> _entries = <QrHistoryEntry>[];

  @override
  Future<void> add(QrHistoryEntry entry) async {
    _entries.insert(0, entry);
  }

  @override
  Future<List<QrHistoryEntry>> getAll() async {
    return List<QrHistoryEntry>.unmodifiable(_entries);
  }
}
