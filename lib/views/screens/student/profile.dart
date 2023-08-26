import 'package:flutter/material.dart';
import 'package:school_management/models/student/profile.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';
import 'package:school_management/views/widgets/cards/list_tile.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class PersonalProfileScreen extends StatelessWidget {
  const PersonalProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final  ThemeData theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
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
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomListTile(
                          leading: const CircleAvatar(
                            radius: 30,
                          ),
                          title: Text("Edilberto Jr. S. Pajunar",
                            style: theme.textTheme.titleSmall!.copyWith(
                            ),
                          ),
                          subtitle: Text("BSCPE 4-5",
                            style: theme.textTheme.bodyMedium!.copyWith(
                            ),
                          ),
                        ),
                        PrimaryTextField(
                          key: ProfileServices.nameKey,
                          controller: ProfileServices.name,
                          label: "Name",
                          hintText: "Name",
                          readOnly: true,
                        ),
                        PrimaryTextField(
                          key: ProfileServices.birthdayKey,
                          controller: ProfileServices.birthday,
                          label: "Date of Birth",
                          hintText: "Date of Birth",
                          readOnly: true,
                        ),
                        PrimaryTextField(
                          key: ProfileServices.learningReferenceNumberKey,
                          controller: ProfileServices.learningReferenceNumber,
                          label: "Learning Reference Number",
                          hintText: "Learning Reference Number",
                          readOnly: true,
                        ),

                        Spacer(),

                        PrimaryButton(
                          onPressed: () {},
                          label: "Edit",
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
