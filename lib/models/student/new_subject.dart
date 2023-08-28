// To parse this JSON data, do
//
//     final subject = subjectFromMap(jsonString);

import 'dart:convert';

Subject subjectFromMap(String str) => Subject.fromMap(json.decode(str));

String subjectToMap(Subject data) => json.encode(data.toMap());

class Subject {
  final String name;
  final bool enrolled;
  final List<Grade?> grades;
  final int? units;
  final int id;

  Subject({
    required this.name,
    required this.enrolled,
    required this.grades,
    required this.units,
    required this.id,
  });

  factory Subject.fromMap(Map<String, dynamic> json) => Subject(
    name: json["name"],
    enrolled: json["enrolled"],
    grades: List<Grade?>.from(json["grades"].map((x) => Grade.fromMap(x))),
    units: json["units"],
    id: json["id"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "enrolled": enrolled,
    "grades": List<dynamic>.from(grades.map((x) => x?.toMap())),
    "units": units,
    "id": id,
  };
}

class Grade {
  final String? title;
  final int? grade;

  Grade({
    this.title,
    this.grade,
  });

  factory Grade.fromMap(Map<String, dynamic> json) => Grade(
    title: json["title"] as String?,
    grade: json["grade"] as int?,
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "grade": grade,
  };
}
