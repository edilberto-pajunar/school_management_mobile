import 'package:flutter/cupertino.dart';

class ProfileServices extends ChangeNotifier {

  static TextEditingController name = TextEditingController();
  static GlobalKey<FormFieldState> nameKey = GlobalKey<FormFieldState>();

  static TextEditingController birthday = TextEditingController();
  static GlobalKey<FormFieldState> birthdayKey = GlobalKey<FormFieldState>();

  static TextEditingController learningReferenceNumber = TextEditingController();
  static GlobalKey<FormFieldState> learningReferenceNumberKey = GlobalKey<FormFieldState>();


}