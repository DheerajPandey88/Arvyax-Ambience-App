class Journal {
  final String text;
  final String mood;
  final DateTime date;
  final String ambience;

  Journal({
    required this.text,
    required this.mood,
    required this.date,
    required this.ambience,
  });
  
  factory Journal.fromJson(Map<String, dynamic> json) {
  return Journal(
    ambience: json['ambience'],
    mood: json['mood'],
    text: json['text'],
    date: DateTime.parse(json['date']),
  );
}

Map<String, dynamic> toJson() {
  return {
    'ambience': ambience,
    'mood': mood,
    'text': text,
    'date': date.toIso8601String(),
  };
}
}