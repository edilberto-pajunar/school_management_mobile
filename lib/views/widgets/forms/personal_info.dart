import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/widgets/buttons/check.dart';
import 'package:school_management/views/widgets/buttons/radio.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class BasicPersonalInfoForm extends StatelessWidget {
  const BasicPersonalInfoForm({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final Application application = Provider.of<Application>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 24.0),
        Text("B. LEARNER INFORMATION",
          style: theme.textTheme.bodyLarge,
        ),

        const SizedBox(height: 12.0),
        Text("B.1. Basic Personal Information",
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        PrimaryTextField(
          fieldKey: Application.learningReferenceNumberKey,
          controller: Application.learningReferenceNumber,
          hintText: "Enter",
          label: "B.1.1 Learning Reference Number (LRN) if assigned.",
          validator: Commons.forcedTextValidator,
        ),
        const SizedBox(height: 12.0),
        Text("Write the name as it spelled in the NSA Birth Certificate. / Gamitin ang pagkasulat ng pangalan ayon sa nasa NSA Birth Certificate",
          style: theme.textTheme.bodyMedium!.copyWith(
            color: ColorTheme.primaryRed,
          ),
        ),

        PrimaryTextField(
          fieldKey: Application.lastNameKey,
          controller: Application.lastName,
          hintText: "Enter",
          label: "B.1.2.1 Last name",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.firstNameKey,
          controller: Application.firstName,
          hintText: "Enter",
          label: "B.1.2.2 First name",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.middleNameKey,
          controller: Application.middleName,
          hintText: "Enter",
          label: "B.1.2.3 Middle name",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.extensionNameKey,
          controller: Application.extensionName,
          hintText: "Enter",
          label: "B.1.2.4 Extension name e.g. Jr.(if applicable)",
        ),

        PrimaryTextField(
          fieldKey: Application.placeOfBirthKey,
          controller: Application.placeOfBirth,
          hintText: "Enter",
          label: "B.1.3.1 Place of Birth(from PSA)",
          validator: Commons.forcedTextValidator,

        ),

        PrimaryTextField(
          fieldKey: Application.dateOfBirthKey,
          controller: Application.dateOfBirth,
          hintText: "Enter",
          label: "B.1.3.2 Date of Birth",
          readOnly: true,
          onTap: () => application.updateBirthDate(context),
        ),

        PrimaryTextField(
          fieldKey: Application.ageKey,
          controller: Application.age,
          hintText: "Enter",
          label: "B.1.3.2 age (today)",
          validator: Commons.forcedTextValidator,

        ),

        const SizedBox(height: 12.0),

        Row(
          children: [
            const Text("B.1.4 Gender"),
            const SizedBox(width: 12.0),
            Row(
              children: application.genderList.map((SelectionOption value) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: CustomRadioButton(
                    value: application.gender == value,
                    onTap: () => application.updateGender(value),
                    label: value.name,
                  ),
                );
              }).toList(),
            ),
          ],
        ),

        Visibility(
          visible: application.gender?.id == 2,
          child: PrimaryTextField(
            fieldKey: Application.otherGenderKey,
            controller: Application.otherGender,
            hintText: "Gender",
            label: "Others (Specify)",
          ),
        ),

        const SizedBox(height: 12.0),

        Row(
          children: [
            const Text("B.1.5 Belonging to Indigenous People?"),
            const SizedBox(width: 12.0),
            CustomCheckbox(
              value: application.isIndigenousPeople,
              onTap: () => application.updateIsIndigenousPeople(false),
              option1: application.isIndigenousPeople ? "Yes" : "No",
            ),
          ],
        ),

        Visibility(
          visible: application.isIndigenousPeople,
          child: PrimaryTextField(
            fieldKey: Application.indigenousGroupKey,
            controller: Application.indigenousGroup,
            hintText: "Indigenous Group",
            label: "Others (Specify)",
          ),
        ),

        PrimaryTextField(
          fieldKey: Application.motherToungeKey,
          controller: Application.motherTounge,
          hintText: "Enter",
          label: "B.1.6.1 Mother Tounge",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.otherLanguagesKey,
          controller: Application.otherLanguages,
          hintText: "Enter",
          label: "B.1.6.2 Other Languages Spoken",
        ),
      ],
    );
  }
}
