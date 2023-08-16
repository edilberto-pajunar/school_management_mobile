import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    super.key,

  });

  final Widget? title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            leading ?? const SizedBox(),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                title ?? const SizedBox(),
                const SizedBox(height: 5.0),
                subtitle ?? const SizedBox.shrink(),
              ],
            ),
          ],
        ),
        trailing ?? const SizedBox.shrink(),
      ],
    );
  }
}
