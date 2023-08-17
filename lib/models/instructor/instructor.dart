class InstructorModel {
  String name;
  String id;

  InstructorModel({
    required this.name,
    required this.id,
  });

  factory InstructorModel.fromJson(Map<String, dynamic> json) => InstructorModel(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}
