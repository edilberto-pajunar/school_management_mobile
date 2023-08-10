import 'package:flutter/material.dart';
import 'package:school_management/values/strings/colors.dart';

class PrimaryTextField extends StatelessWidget {
  const PrimaryTextField({
    this.fieldKey,
    required this.controller,
    required this.hintText,
    required this.label,
    this.validator,
    this.onChanged,
    super.key,

  });

  final GlobalKey<FormFieldState>? fieldKey;
  final TextEditingController controller;
  final String hintText;
  final String label;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 4.0),
        TextFormField(
          key: fieldKey,
          onTapOutside: (PointerDownEvent event) => FocusScope.of(context).unfocus(),
          controller: controller,
          decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide(
                color: ColorTheme.primaryBlack,
              ),
            ),
          ),
          validator: validator,
          onChanged: (value) => fieldKey!.currentState!.validate(),
        ),
      ],
    );
  }
}
