import 'package:school_management/models/registration/emergency_info.dart';
import 'package:school_management/models/registration/personal_info.dart';
import 'package:school_management/models/registration/residence_info.dart';
import 'package:school_management/models/registration/school_info.dart';

class ApplicationInfo {
  ApplicationInfo({
    required this.schoolInfo,
    required this.personalInfo,
    required this.emergencyInfo,
    required this.residenceInfo,
  });

  final SchoolInfo schoolInfo;
  final PersonalInfo personalInfo;
  final EmergencyInfo emergencyInfo;
  final ResidenceInfo residenceInfo;

  factory ApplicationInfo.fromJson(Map<String, dynamic> json) {
    return ApplicationInfo(
      schoolInfo: SchoolInfo.fromJson(json["schoolInfo"]),
      personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
      emergencyInfo: EmergencyInfo.fromJson(json["emergencyInfo"]),
      residenceInfo: ResidenceInfo.fromJson(json["residenceInfo"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolInfo': schoolInfo.toJson(),
      'personalInfo': personalInfo.toJson(),
      'emergencyInfo': emergencyInfo.toJson(),
      'residenceInfo': residenceInfo.toJson(),
    };
  }
}