import 'package:flutter/material.dart';
import 'package:school_management/values/strings/colors.dart';

class InstructorClassCard extends StatelessWidget {
  const InstructorClassCard({
    required this.label,
    required this.onTap,
    super.key,
  });

  final String label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        splashColor: ColorTheme.primaryRed,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          height: 80,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                style: theme.textTheme.titleLarge!,
              ),
              const Icon(Icons.arrow_circle_right),
            ],
          ),
        ),
      ),
    );
  }
}
