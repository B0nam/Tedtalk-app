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
      id: int.tryParse(json['id'].toString()) ?? 0,
      title: json['title'] as String,
      tedTalks: (json['tedTalks'] as List)
          .map((e) => int.tryParse(e.toString()) ?? 0)
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
