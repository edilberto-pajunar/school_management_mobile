import 'package:flutter/material.dart';
import 'package:school_management/values/strings/colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  const CustomDropdown({
    required this.value,
    required this.items,
    required this.label,
    required this.onChanged,
    super.key,
  });

  final T? value;
  final List<DropdownMenuItem> items;
  final String label;
  final Function(dynamic)? onChanged;

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label,),
        const SizedBox(height: 4.0),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: ColorTheme.primaryBlack,
            )
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              value: value,
              hint: Text("Select",
                style: theme.textTheme.bodyMedium!.copyWith(
                  color: ColorTheme.primaryRed.withOpacity(0.25),
                ),
              ),
              isExpanded: true,
              items: items,
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
