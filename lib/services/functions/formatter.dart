import 'package:flutter/services.dart';

class PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueText = newValue.text;

    // Apply the +63 prefix and limit to 13 characters
    if (newValueText.startsWith('+63')) {
      return newValue;
    } else if (newValueText.isEmpty || newValueText.length <= 3) {
      return TextEditingValue(
        text: '+63$newValueText',
        selection: TextSelection.collapsed(offset: newValueText.length + 3),
      );
    } else {
      return TextEditingValue(
        text: '+63${newValueText.substring(3)}',
        selection: TextSelection.collapsed(offset: newValueText.length - 3),
      );
    }
  }
}