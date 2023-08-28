import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/registration/application.dart';
import 'package:school_management/services/networks/student/db.dart';
import 'package:school_management/views/widgets/body/stream_wrapper.dart';
import 'package:school_management/views/widgets/cards/list_tile.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class PersonalProfileScreen extends StatefulWidget {
  const PersonalProfileScreen({super.key});

  @override
  State<PersonalProfileScreen> createState() => _PersonalProfileScreenState();
}

class _PersonalProfileScreenState extends State<PersonalProfileScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final StudentDB studentDB = Provider.of<StudentDB>(context, listen: false);
      studentDB.updateStudentProfileStream(context);
      // studentDB.updateSubjectStream(context);
    });
  }

  @override
  Widget build(BuildContext context) {

    final  ThemeData theme = Theme.of(context);
    final StudentDB studentDB = Provider.of<StudentDB>(context);


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Student Profile"),
        ),
        body: StreamWrapper<ApplicationInfo>(
          stream: studentDB.studentProfileStream,
          child: (profile) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomListTile(
                      leading: const CircleAvatar(
                        radius: 30,
                      ),
                      title: Text(profile!.personalInfo.firstName + profile.personalInfo.lastName,
                        style: theme.textTheme.titleSmall!.copyWith(
                        ),
                      ),
                      subtitle: Text("BSCPE 4-5",
                        style: theme.textTheme.bodyMedium!.copyWith(
                        ),
                      ),
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: PrimaryTextField(
                    //         controller: TextEditingController(text: profile.schoolInfo.gradeToEnroll),
                    //         label: "Level",
                    //       ),
                    //     ),
                    //     const SizedBox(width: 12.0),
                    //     Expanded(
                    //       child: PrimaryTextField(
                    //         controller: TextEditingController(text: profile.schoolInfo.),
                    //         label: "Level",
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 24.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            studentDB.updateHidePersonal();
                          },
                          child: Row(
                            children: [
                              studentDB.hidePersonal
                                ? const Icon(Icons.arrow_drop_down)
                                : const Icon(Icons.arrow_drop_up_sharp),
                              Text("Personal Information",
                                style: theme.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: studentDB.hidePersonal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryTextField(
                                controller: TextEditingController(text: profile.personalInfo.dateOfBirth),
                                label: "Birth Date",
                                readOnly: true,
                              ),
                              PrimaryTextField(
                                controller: TextEditingController(text: profile.personalInfo.placeOfBirth),
                                label: "Birth Place",
                                readOnly: true,
                              ),
                              PrimaryTextField(
                                controller: TextEditingController(text: profile.personalInfo.gender),
                                label: "Sex",
                                readOnly: true,
                              ),
                              PrimaryTextField(
                                controller: TextEditingController(text: profile.personalInfo.age),
                                label: "Age",
                                readOnly: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            studentDB.updateHideContact();
                          },
                          child: Row(
                            children: [
                              studentDB.hideContact
                                  ? const Icon(Icons.arrow_drop_down)
                                  : const Icon(Icons.arrow_drop_up_sharp),
                              Text("Addresses & Contacts",
                                style: theme.textTheme.titleSmall,
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: studentDB.hideContact,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryTextField(
                                controller: TextEditingController(text: profile.emergencyInfo.contactNumber),
                                label: "Contact Number",
                                readOnly: true,
                              ),
                              PrimaryTextField(
                                controller: TextEditingController(text: profile.emergencyInfo.address),
                                label: "Address",
                                readOnly: true,
                              ),
                              PrimaryTextField(
                                controller: TextEditingController(text: profile.emergencyInfo.emergencyPerson),
                                label: "Emergency Person",
                                readOnly: true,
                              ),
                              PrimaryTextField(
                                controller: TextEditingController(text: profile.emergencyInfo.number),
                                label: "Emergency Contact Number",
                                readOnly: true,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24.0),
                    // PrimaryButton(
                    //   onPressed: () {
                    //     studentDB.updateCanEdit();
                    //   },
                    //   label: studentDB.canEdit
                    //       ? "Save"
                    //       : "Edit",
                    // ),
                  ],
                ),
              ),
            );
          }
        )
      ),
    );
  }
}
