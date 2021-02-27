import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  Student({
    this.id,
    this.name,
    this.score,
  });

  String id;
  String name;
  int score;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json['id'],
        name: json['name'],
        score: json['score'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'score': score,
      };
}
