import 'package:flutter/cupertino.dart';

class Commons extends ChangeNotifier {

  static String? forcedTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }
}