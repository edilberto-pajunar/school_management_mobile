class StudentModel {
  String grade;
  String section;
  String id;
  String name;
  String lrn;
  Grades grades;

  StudentModel({
    required this.grade,
    required this.section,
    required this.id,
    required this.name,
    required this.lrn,
    required this.grades,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    grade: json["grade"],
    section: json["section"],
    id: json["id"],
    name: json["name"],
    lrn: json["lrn"],
    grades: Grades.fromJson(json["grades"]),
  );

  Map<String, dynamic> toJson() => {
    "grade": grade,
    "section": section,
    "id": id,
    "name": name,
    "lrn": lrn,
    "grades": grades.toJson(),
  };
}

class Grades {
  List<int> mapeh;
  List<int> mathematics;

  Grades({
    required this.mapeh,
    required this.mathematics,
  });

  factory Grades.fromJson(Map<String, dynamic> json) => Grades(
    mapeh: List<int>.from(json["mapeh"].map((x) => x)),
    mathematics: List<int>.from(json["mathematics"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "mapeh": List<dynamic>.from(mapeh.map((x) => x)),
    "mathematics": List<dynamic>.from(mathematics.map((x) => x)),
  };
}
