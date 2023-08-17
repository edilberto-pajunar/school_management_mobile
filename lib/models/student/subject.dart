import 'package:school_management/models/instructor/instructor.dart';

class SubjectModel {
  String title;
  int? grade;
  String id;
  int semester;
  String strand;
  InstructorModel instructor;
  String year;
  int unit;

  SubjectModel({
    required this.title,
    this.grade,
    required this.id,
    required this.semester,
    required this.strand,
    required this.instructor,
    required this.year,
    required this.unit,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) => SubjectModel(
    title: json["title"] as String,
    grade: json["grade"] as int?,
    id: json["id"] as String,
    semester: json["semester"] as int,
    strand: json["strand"] as String,
    year: json["year"] as String,
    unit: json["unit"] as int,
    instructor: InstructorModel.fromJson(json["instructor"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "grade": grade,
    "id": id,
    "semester": semester,
    "strand": strand,
    "instructor": instructor.toJson(),
    "year": year,
    "unit": unit,
  };
}
