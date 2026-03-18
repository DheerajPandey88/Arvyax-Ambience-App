import 'dart:convert';
import 'package:flutter/services.dart';
import  'package:arvyax_application/data/models/ambience_model.dart';

class AmbienceRepository {
  Future<List<Ambience>> loadAmbiences() async {
    final data = await rootBundle.loadString('assets/ambiences.json');
    final jsonResult = json.decode(data);

    return (jsonResult as List)
        .map((e) => Ambience.fromJson(e))
        .toList();
  }
}