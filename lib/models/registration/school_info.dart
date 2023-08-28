// To parse this JSON data, do
//
//     final schoolInfo = schoolInfoFromJson(jsonString);

import 'dart:convert';

SchoolInfo schoolInfoFromJson(String str) => SchoolInfo.fromJson(json.decode(str));

String schoolInfoToJson(SchoolInfo data) => json.encode(data.toJson());

class SchoolInfo {
  String schoolYear;
  String gradeToEnroll;
  String lastGradeCompleted;
  String lastSchoolYear;
  String residency;
  // bool lrnAssigned;
  // String? lrn;
  String nameOfSchool;
  String schoolId;
  String schoolAddress;
  String schoolType;
  bool isPsaSubmitted;
  String birthCertificate;
  String otherRequirements;
  String? semester;
  String? track;
  String? strand;

  SchoolInfo({
    required this.schoolYear,
    required this.gradeToEnroll,
    required this.lastGradeCompleted,
    required this.lastSchoolYear,
    required this.residency,
    required this.nameOfSchool,
    required this.schoolId,
    required this.schoolAddress,
    required this.schoolType,
    required this.isPsaSubmitted,
    required this.birthCertificate,
    required this.otherRequirements,
    this.semester,
    this.track,
    this.strand,
  });

  factory SchoolInfo.fromJson(Map<String, dynamic> json) => SchoolInfo(
    schoolYear: json["schoolYear"] as String,
    gradeToEnroll: json["gradeToEnroll"] as String,
    residency: json["residency"] as String,
    lastGradeCompleted: json["lastGradeCompleted"] as String,
    lastSchoolYear: json["lastSchoolYear"] as String,
    nameOfSchool: json["nameOfSchool"] as String,
    schoolId: json["schoolId"] as String,
    schoolAddress: json["schoolAddress"] as String,
    schoolType: json["schoolType"] as String,
    isPsaSubmitted: json["isPSASubmitted"] as bool,
    birthCertificate: json["birthCertificate"] as String,
    otherRequirements: json["otherRequirements"] as String,
    semester: json["semester"] as String? ?? "",
    track: json["track"] as String ? ?? "",
    strand: json["strand"] as String? ?? "",
  );

  Map<String, dynamic> toJson() => {
    "schoolYear": schoolYear,
    "gradeToEnroll": gradeToEnroll,
    "lastGradeCompleted": lastGradeCompleted,
    "lastSchoolYear": lastSchoolYear,
    "residency": residency,
    "nameOfSchool": nameOfSchool,
    "schoolId": schoolId,
    "schoolAddress": schoolAddress,
    "schoolType": schoolType,
    "isPSASubmitted": isPsaSubmitted,
    "birthCertificate": birthCertificate,
    "otherRequirements": otherRequirements,
    "semester": semester,
    "track": track,
    "strand": strand,
  };
}
