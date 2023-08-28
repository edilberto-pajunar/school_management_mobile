import 'package:flutter/material.dart';
import 'package:school_management/models/student/new_subject.dart';

class CustomShowDialog {

  Future<void> showGradesDialog(BuildContext context, {
    required int index, required Subject subject
  }) async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {

        final ThemeData theme = Theme.of(context);

        final grade = subject.grades.map((Grade? e) {
          return e!.grade;
        }).toList();

        final title = subject.grades.map((Grade? e) {
          return e!.title;
        }).toList();

        return Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text("${subject.name} overall grades",
                  style: theme.textTheme.headlineSmall,
                ),
                const SizedBox(height: 50.0),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: subject.grades.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${title[index]!.toUpperCase()} SEMESTER",
                              style: theme.textTheme.titleSmall,
                            ),

                            Text("${grade[index]}",
                              style: theme.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        Divider(
                          thickness: 3,
                          height: 24.0,
                          color: Colors.black,
                        ),
                      ],
                    );
                }),
              ],
            ),
          )
        );
      });
  }

}