import 'package:flutter/material.dart';

class SchoolDropdownMenuItem<T> {
  const SchoolDropdownMenuItem({
    required this.value,
    required this.label,
    required this.child,
  });

  final T? value;
  final String label;
  final Widget child;
}

class SelectionOption<T> {
  const SelectionOption({
    required this.id,
    required this.label,
  });

  final T? id;
  final String label;

  factory SelectionOption.fromJson(Map<String, dynamic> json) {
    return SelectionOption(
      id: json["id"] as T,
      label: json["name"] as String,
    );
  }
}