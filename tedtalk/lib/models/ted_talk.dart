class TedTalk {
  final int id;
  final String name;
  final String image;
  final String speaker;
  final Duration duration;
  final String description;

  TedTalk({
    required this.id,
    required this.name,
    required this.image,
    required this.speaker,
    required this.duration,
    required this.description,
  });

  factory TedTalk.fromJson(Map<String, dynamic> json) {
    return TedTalk(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      speaker: json['speaker'] as String,
      duration: Duration(minutes: json['duration'] as int),
      description: json['description'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'speaker': speaker,
      'duration': duration.inMinutes,
      'description': description,
    };
  }
}
