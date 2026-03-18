import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:arvyax_application/data/models/journal_model.dart';

class JournalController extends ChangeNotifier {
  List<Journal> journals = [];

  /// 🔄 LOAD FROM STORAGE
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('journals');

    if (data != null) {
      final List decoded = jsonDecode(data);

      journals = decoded
          .map((e) => Journal.fromJson(e))
          .toList()
          .reversed
          .toList();

      notifyListeners();
    }
  }

  /// ➕ ADD ENTRY
  Future<void> add(Journal j) async {
    journals.insert(0, j); // latest first
    await save();
    notifyListeners();
  }

  /// 💾 SAVE TO STORAGE
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();

    final data =
        jsonEncode(journals.map((e) => e.toJson()).toList());

    await prefs.setString('journals', data);
  }

  /// 🗑 CLEAR ALL (optional)
  Future<void> clear() async {
    journals.clear();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('journals');
    notifyListeners();
  }
}