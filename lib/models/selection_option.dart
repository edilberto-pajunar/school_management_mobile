class SelectionOption {
  SelectionOption({
    required this.id,
    required this.name
  });

  final int id;
  final String name;

  factory SelectionOption.fromJson(Map<String, dynamic> json) {
    return SelectionOption(
      id: json["id"] as int,
      name: json["name"] as String,
    );
  }
}