class TedTalk {
  final String id;
  final String title;

  TedTalk({
    required this.id,
    required this.title,
  });

  factory TedTalk.fromJson(Map<String, dynamic> json) {
    return TedTalk(
      id: json['id'],
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title};
  }
}
