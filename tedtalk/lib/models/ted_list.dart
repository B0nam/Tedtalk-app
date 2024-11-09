class TedList {
  final String id;
  final String title;
  final List<String> tedTalks;

  TedList({
    required this.id,
    required this.title,
    required this.tedTalks,
  });

  factory TedList.fromJson(Map<String, dynamic> json) {
    return TedList(
      id: json['id'].toString(),
      title: json['title'] as String,
      tedTalks: List<String>.from(json['tedTalks'].map((e) => e.toString())),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'tedTalks': tedTalks,
    };
  }
}
