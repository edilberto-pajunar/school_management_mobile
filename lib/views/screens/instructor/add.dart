import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/instructor/db.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class AddStudentsScreen extends StatelessWidget {
  const AddStudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final InstructorDB db = Provider.of<InstructorDB>(context);

    final ThemeData theme = Theme.of(context);
    final NavigationServices nav = NavigationServices();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              nav.pop(context);
              db.clearForm();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: Text("Add Students",
            style: theme.textTheme.titleSmall!.copyWith(
              color: Colors.white,
            ),
          ),
        ),
        body: LayoutBuilder(
            builder: (context, constraints) {


              return ModalProgressHUD(
                inAsyncCall: db.isLoading,
                child: Form(
                  key: InstructorDB.formKey,
                  child: SingleChildScrollView(
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

                              // PrimaryTextField(
                              //   fieldKey: InstructorDB.gradeKey,
                              //   controller: InstructorDB.gradeField,
                              //   label: "Grade",
                              //   hintText: "Enter",
                              //   validator: Commons.forcedTextValidator,
                              // ),

                              const SizedBox(height: 12.0),
                              const Text("Grade"),
                              const SizedBox(height: 4.0,),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: db.gradeList.map((SelectionOption grade) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8.0,
                                      horizontal: 25.0
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(12.0),
                                      splashColor: ColorTheme.primaryRed,
                                      onTap: () => db.updateGrade(grade),
                                      child: Container(
                                        width: MediaQuery.of(context).size.width * 0.3,
                                        padding: const EdgeInsets.all(12.0),
                                        decoration: BoxDecoration(
                                          color: grade == db.grade ? ColorTheme.primaryRed : Colors.white,
                                          borderRadius: BorderRadius.circular(12.0),
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(grade.label,
                                            style: theme.textTheme.bodyMedium!.copyWith(
                                              color: grade == db.grade ? Colors.white : ColorTheme.primaryBlack,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),

                              PrimaryTextField(
                                fieldKey: InstructorDB.sectionKey,
                                controller: InstructorDB.sectionField,
                                label: "Section",
                                hintText: "Enter",
                                validator: Commons.forcedTextValidator,
                              ),

                              const SizedBox(height: 24.0),

                              const Spacer(),

                              PrimaryButton(
                                onPressed: () async {
                                  if (InstructorDB.formKey.currentState!.validate()
                                    && db.grade != null
                                  ) {
                                    await db.addStudentFuture(context);
                                  }
                                },
                                label: "Submit",
                              ),

                            ],
                          ),
                        ),
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
