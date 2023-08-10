import 'package:flutter/material.dart';
import 'package:school_management/values/strings/colors.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.label,
    super.key,
  });

  final Function() onPressed;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: const  EdgeInsets.symmetric(vertical: 16.0,),
        backgroundColor: ColorTheme.primaryRed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        )
      ),
      child: Text(label,

      ),
    );
  }
}
