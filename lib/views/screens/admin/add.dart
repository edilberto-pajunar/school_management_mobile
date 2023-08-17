import 'package:flutter/material.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/instructor/db.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class AddStudentsScreen extends StatelessWidget {
  const AddStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Add Students",
            style: theme.textTheme.titleSmall!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          PrimaryTextField(
                            fieldKey: InstructorDB.nameKey,
                            controller: InstructorDB.nameField,
                            label: "Name",
                            hintText: "Enter",
                            validator: Commons.forcedTextValidator,
                          ),

                          PrimaryTextField(
                            fieldKey: InstructorDB.gradeKey,
                            controller: InstructorDB.gradeField,
                            label: "Grade",
                            hintText: "Enter",
                            validator: Commons.forcedTextValidator,
                          ),

                          PrimaryTextField(
                            fieldKey: InstructorDB.sectionKey,
                            controller: InstructorDB.sectionField,
                            label: "Section",
                            hintText: "Enter",
                            validator: Commons.forcedTextValidator,
                          ),

                          const SizedBox(height: 24.0),

                          Spacer(),

                          PrimaryButton(
                            onPressed: () {},
                            label: "Submit",
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
