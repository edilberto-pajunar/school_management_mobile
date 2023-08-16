import 'package:flutter/material.dart';

class FutureWrapper<T> extends StatelessWidget {
  const FutureWrapper({
    Key? key,
    required this.future,
    required this.child,
    this.progressIndicator,
    this.errorWidget,
  }) : super(key: key);

  final Future<T>? future;
  final Widget Function(T? data) child;
  final Widget? progressIndicator;
  final Widget Function(Object?)? errorWidget;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          final T? data = snapshot.data;
          return child(data);
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());

          if (errorWidget != null) {
            return errorWidget!(snapshot.error);
          } else {
            return Center(
              child: Text(
                "Something went wrong.\nPlease try again later.",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge,
              ),
            );
          }
        } else {
          return progressIndicator ?? const Center(
            child: CircularProgressIndicator(),
          );

        }
      },
    );
  }
}