import 'dart:convert';

class Album {
  Album({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  final int userId;
  final int id;
  final String title;
  final String body;

  factory Album.fromJson(String str) => Album.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Album.fromMap(Map<String, dynamic> json) => Album(
        userId: json['userId'],
        id: json['id'],
        title: json['title'],
        body: json['body'],
      );

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };
}
