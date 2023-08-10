// To parse this JSON data, do
//
//     final residence = residenceFromJson(jsonString);

import 'dart:convert';

ResidenceInfo residenceFromJson(String str) => ResidenceInfo.fromJson(json.decode(str));

String residenceToJson(ResidenceInfo data) => json.encode(data.toJson());

class ResidenceInfo {
  String household;
  Address currentAddress;
  Address familyAddress;
  List<String> familyInfo;
  String statusOfParents;
  String numberOfBrothers;
  String numberOfSisters;

  ResidenceInfo({
    required this.household,
    required this.currentAddress,
    required this.familyAddress,
    required this.familyInfo,
    required this.statusOfParents,
    required this.numberOfBrothers,
    required this.numberOfSisters,
  });

  factory ResidenceInfo.fromJson(Map<String, dynamic> json) => ResidenceInfo(
    household: json["household"],
    currentAddress: Address.fromJson(json["currentAddress"]),
    familyAddress: Address.fromJson(json["familyAddress"]),
    familyInfo: List<String>.from(json["familyInfo"].map((x) => x)),
    statusOfParents: json["statusOfParents"] as String,
    numberOfBrothers: json["numberOfBrothers"] as String,
    numberOfSisters: json["numberOfSisters"] as String,
  );

  Map<String, dynamic> toJson() => {
    "household": household,
    "currentAddress": currentAddress.toJson(),
    "familyAddress": familyAddress.toJson(),
    "familyInfo": List<dynamic>.from(familyInfo.map((x) => x)),
    "statusOfParents": statusOfParents,
    "numberOfBrothers": numberOfBrothers,
    "numberOfSisters": numberOfSisters,
  };
}

class Address {
  String addres;
  String barangay;
  String city;
  String province;
  String region;

  Address({
    required this.addres,
    required this.barangay,
    required this.city,
    required this.province,
    required this.region,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    addres: json["addres"],
    barangay: json["barangay"],
    city: json["city"],
    province: json["province"],
    region: json["region"],
  );

  Map<String, dynamic> toJson() => {
    "addres": addres,
    "barangay": barangay,
    "city": city,
    "province": province,
    "region": region,
  };
}
