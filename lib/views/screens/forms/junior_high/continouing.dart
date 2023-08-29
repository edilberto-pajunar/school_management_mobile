import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/networks/navigation.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/views/widgets/buttons/primary.dart';
import 'package:school_management/views/widgets/forms/emergency.dart';
import 'package:school_management/views/widgets/forms/family_info.dart';
import 'package:school_management/views/widgets/forms/personal_info.dart';
import 'package:school_management/views/widgets/forms/residence.dart';
import 'package:school_management/views/widgets/forms/school_info.dart';


class ContinueJuniorScreen extends StatelessWidget {
  const ContinueJuniorScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final Application application = Provider.of<Application>(context);
    final NavigationServices nav = NavigationServices();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            nav.pop(context);
            application.clearForm();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Application Form"),
      ),
      body: ModalProgressHUD(
        inAsyncCall: application.isLoading,
        child: Form(
          key: Application.formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("For Continuing Junior High School Enrollment Form",
                      style: theme.textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SchoolInfoForm(
                      continueJunior: true,
                    ),
                    const BasicPersonalInfoForm(),
                    const EmergencyForm(),
                    const ResidenceForm(),
                    const FamilyInformationForm(),
                    const SizedBox(height: 24.0),
                    PrimaryButton(
                      onPressed: () async {
                        if (Application.formKey.currentState!.validate()) {
                          await application.submitApplicationForm(context,
                            isJunior: true,

                          ).then((value) {
                            nav.pop(context);
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                content: Text("Submitted Successfully",
                                  style: theme.textTheme.bodyMedium,
                                ),
                              );
                            });
                          });
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
}
