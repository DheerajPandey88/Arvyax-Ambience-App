class Ambience {
  final String id;
  final String title;
  final String tag;
  final int duration; // seconds
  final String image;
  final String audio;
  final String description;
  final List<String> sensory;

  Ambience({
    required this.id,
    required this.title,
    required this.tag,
    required this.duration,
    required this.image,
    required this.audio,
    required this.description,
    required this.sensory,
  });

  factory Ambience.fromJson(Map<String, dynamic> json) {
    return Ambience(
      id: json['id'],
      title: json['title'],
      tag: json['tag'],
      duration: json['duration'],
      image: json['image'],
      audio: json['audio'],
      description: json['description'],
      sensory: List<String>.from(json['sensory']),
    );
  }
}