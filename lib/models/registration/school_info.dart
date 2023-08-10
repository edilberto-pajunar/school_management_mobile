// To parse this JSON data, do
//
//     final schoolInfo = schoolInfoFromJson(jsonString);

import 'dart:convert';

SchoolInfo schoolInfoFromJson(String str) => SchoolInfo.fromJson(json.decode(str));

String schoolInfoToJson(SchoolInfo data) => json.encode(data.toJson());

class SchoolInfo {
  String schoolYear;
  bool lrnAssigned;
  String residency;
  String gradeToEnroll;
  String lastGradeCompleted;
  String lastSchoolYear;
  String nameOfSchool;
  String schoolId;
  String schoolAddress;
  String schoolType;
  bool isPsaSubmitted;
  String otherRequirements;

  SchoolInfo({
    required this.schoolYear,
    required this.lrnAssigned,
    required this.residency,
    required this.gradeToEnroll,
    required this.lastGradeCompleted,
    required this.lastSchoolYear,
    required this.nameOfSchool,
    required this.schoolId,
    required this.schoolAddress,
    required this.schoolType,
    required this.isPsaSubmitted,
    required this.otherRequirements,
  });

  factory SchoolInfo.fromJson(Map<String, dynamic> json) => SchoolInfo(
    schoolYear: json["schoolYear"] as String,
    lrnAssigned: json["lrnAssigned"] as bool,
    residency: json["residency"] as String,
    gradeToEnroll: json["gradeToEnroll"] as String,
    lastGradeCompleted: json["lastGradeCompleted"] as String,
    lastSchoolYear: json["lastSchoolYear"] as String,
    nameOfSchool: json["nameOfSchool"] as String,
    schoolId: json["schoolId"] as String,
    schoolAddress: json["schoolAddress"] as String,
    schoolType: json["schoolType"] as String,
    isPsaSubmitted: json["isPSASubmitted"] as bool,
    otherRequirements: json["otherRequirements"] as String,
  );

  Map<String, dynamic> toJson() => {
    "schoolYear": schoolYear,
    "lrnAssigned": lrnAssigned,
    "residency": residency,
    "gradeToEnroll": gradeToEnroll,
    "lastGradeCompleted": lastGradeCompleted,
    "lastSchoolYear": lastSchoolYear,
    "nameOfSchool": nameOfSchool,
    "schoolId": schoolId,
    "schoolAddress": schoolAddress,
    "schoolType": schoolType,
    "isPSASubmitted": isPsaSubmitted,
    "otherRequirements": otherRequirements,
  };
}
