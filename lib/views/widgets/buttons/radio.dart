import 'package:flutter/material.dart';
import 'package:school_management/values/strings/colors.dart';

class CustomRadioButton extends StatelessWidget {
  const CustomRadioButton({
    required this.value,
    required this.onTap,
    required this.label,
    super.key,
  });

  final bool value;
  final Function() onTap;
  final String label;

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
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorTheme.primaryBlack,
              ),
            ),
            child: Center(
              child: Icon(Icons.circle,
                size: 18,
                color: value
                  ? ColorTheme.primaryRed
                  : Colors.transparent,
              ),
            ),
          ),
        ),
        const SizedBox(width: 4.0),
        Text(label,
          softWrap: true,
        ),
      ],
    );
  }
}
