class UserModel {
  UserModel({
    required this.controlNumber,
    required this.type,
    required this.id,
  });

  final String controlNumber;
  final String type;
  final String id;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      controlNumber: json["controlNumber"],
      type: json["type"],
      id: json["id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "controlNumber": controlNumber,
    "type": type,
    "id": id,
  };
}