import 'package:arvyax_application/data/models/journal_model.dart';

class JournalRepository {
  final List<Journal> _journals = [];

  List<Journal> getJournals() {
    return _journals.reversed.toList();
  }

  void addJournal(Journal journal) {
    _journals.add(journal);
  }
}