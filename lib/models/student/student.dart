class StudentModel {
  String? controlNumber;
  String name;
  String grade;
  String id;
  String? lrn;
  String section;

  StudentModel({
    this.controlNumber,
    required this.name,
    required this.grade,
    required this.id,
    this.lrn,
    required this.section,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    controlNumber: json["control_number"],
    name: json["name"],
    grade: json["grade"],
    id: json["id"],
    lrn: json["lrn"],
    section: json["section"],
  );

  Map<String, dynamic> toJson() => {
    "control_number": controlNumber,
    "name": name,
    "grade": grade,
    "id": id,
    "lrn": lrn,
    "section": section,
  };
}
