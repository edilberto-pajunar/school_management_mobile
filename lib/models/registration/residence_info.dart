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
  String familyInfo;
  String statusOfParents;
  String numberOfBrothers;
  String numberOfSisters;
  bool is4psBeneficiary;
  String whenBeneficiary;
  String printedName;
  String printedRelation;
  String printedDate;

  ResidenceInfo({
    required this.household,
    required this.currentAddress,
    required this.familyAddress,
    required this.familyInfo,
    required this.statusOfParents,
    required this.numberOfBrothers,
    required this.numberOfSisters,
    required this.is4psBeneficiary,
    required this.whenBeneficiary,
    required this.printedName,
    required this.printedRelation,
    required this.printedDate,
  });

  factory ResidenceInfo.fromJson(Map<String, dynamic> json) => ResidenceInfo(
    household: json["household"],
    currentAddress: Address.fromJson(json["currentAddress"]),
    familyAddress: Address.fromJson(json["familyAddress"]),
    familyInfo: json["familyInfo"] as String,
    statusOfParents: json["statusOfParents"] as String,
    numberOfBrothers: json["numberOfBrothers"] as String,
    numberOfSisters: json["numberOfSisters"] as String,
    is4psBeneficiary: json["is4psBeneficiary"] as bool,
    whenBeneficiary: json["whenBeneficiary"] as String,
    printedName: json["printedName"] as String,
    printedRelation: json["printedRelation"] as String,
    printedDate: json["printedDate"] as String,
  );

  Map<String, dynamic> toJson() => {
    "household": household,
    "currentAddress": currentAddress.toJson(),
    "familyAddress": familyAddress.toJson(),
    "familyInfo": familyInfo,
    "statusOfParents": statusOfParents,
    "numberOfBrothers": numberOfBrothers,
    "numberOfSisters": numberOfSisters,
    "is4psBeneficiary": is4psBeneficiary,
    "whenBeneficiary": whenBeneficiary,
    "printedName": printedName,
    "printedRelation": printedRelation,
    "printedDate": printedDate,
  };
}

class Address {
  String address;
  String barangay;
  String city;
  String province;
  String region;

  Address({
    required this.address,
    required this.barangay,
    required this.city,
    required this.province,
    required this.region,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
    barangay: json["barangay"],
    city: json["city"],
    province: json["province"],
    region: json["region"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
    "barangay": barangay,
    "city": city,
    "province": province,
    "region": region,
  };
}
