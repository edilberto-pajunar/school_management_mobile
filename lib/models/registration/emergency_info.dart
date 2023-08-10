// To parse this JSON data, do
//
//     final emergencyInfo = emergencyInfoFromJson(jsonString);

import 'dart:convert';

EmergencyInfo emergencyInfoFromJson(String str) => EmergencyInfo.fromJson(json.decode(str));

String emergencyInfoToJson(EmergencyInfo data) => json.encode(data.toJson());

class EmergencyInfo {
  String communication;
  String number;
  String emergencyPerson;
  String emergencyAddress;
  String relasyon;
  String contactNumber;

  EmergencyInfo({
    required this.communication,
    required this.number,
    required this.emergencyPerson,
    required this.emergencyAddress,
    required this.relasyon,
    required this.contactNumber,
  });

  factory EmergencyInfo.fromJson(Map<String, dynamic> json) => EmergencyInfo(
    communication: json["communication"],
    number: json["number"],
    emergencyPerson: json["emergencyPerson"],
    emergencyAddress: json["emergencyAddress"],
    relasyon: json["Relasyon"],
    contactNumber: json["Contact Number"],
  );

  Map<String, dynamic> toJson() => {
    "communication": communication,
    "number": number,
    "emergencyPerson": emergencyPerson,
    "emergencyAddress": emergencyAddress,
    "Relasyon": relasyon,
    "Contact Number": contactNumber,
  };
}
