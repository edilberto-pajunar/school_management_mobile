import 'package:flutter/cupertino.dart';
import 'package:school_management/models/student/new_subject.dart';

class Commons extends ChangeNotifier {

  static String? forcedTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? forcedDropdownValidator(value) {
    if (value == null) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static List<Subject> juniorSubject = [
    Subject(name: "Filipino", enrolled: false, grades: [
    ], id: 0, units: 3),
    Subject(name: "English", enrolled: false, grades: [], id: 1, units: 4),
    Subject(name: "Mathematics", enrolled: false, grades: [], id: 2, units: 1),
    Subject(name: "Science", enrolled: false, grades: [], id: 3, units: 3),
  ];
}