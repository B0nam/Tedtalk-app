class TedList {
  final int id;
  final String title;
  final List<int> tedTalks;

  TedList({
    required this.id,
    required this.title,
    required this.tedTalks,
  });

  factory TedList.fromJson(Map<String, dynamic> json) {
    return TedList(
      id: json['id'] as int,
      title: json['title'] as String,
      tedTalks: (json['tedTalks'] as List)
          .map((e) => int.parse(e.toString()))
          .toList(),
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
