import 'package:flutter/material.dart';
import 'package:school_management/values/strings/colors.dart';

class CustomCheckbox extends StatelessWidget {
  const CustomCheckbox({
    required this.value,
    required this.onTap,
    this.option1,
    super.key,
  });

  final bool value;
  final Function() onTap;
  final String? option1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.0),
              color: value
                ? ColorTheme.primaryRed
                : Colors.white,
              border: Border.all(
                color: Colors.black
              ),
            ),
            child: Center(
              child: Icon(Icons.check,
                size: 18,
                color: value ? Colors.white : Colors.transparent,
              ),
            ),
          ),
        ),
        const SizedBox(width: 4.0),
        Text(option1 ?? "")
      ],
    );
  }
}
