import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/values/strings/colors.dart';
import 'package:school_management/views/widgets/buttons/dropdown.dart';
import 'package:school_management/views/widgets/fields/dropdown.dart';
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
        const SizedBox(height: 12.0),

        CustomDropdown<SelectionOption>(
          initialValue: application.hasLRN,
          value: application.hasLRN,
          label: "Learning References Number (LRN)",
          hintText: 'Select',
          items: application.agreeDisagree.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateHasLRN,
          validator: Commons.forcedDropdownValidator,
        ),

        Visibility(
          visible: application.hasLRN?.label == "Yes",
          child: PrimaryTextField(
            fieldKey: Application.learningReferenceNumberKey,
            controller: Application.learningReferenceNumber,
            hintText: "Enter your assigned LRN",
            label: "Learning Reference Number (LRN)",
            validator: Commons.forcedTextValidator,
          ),
        ),
        const SizedBox(height: 12.0),
        Text("Write the name as it spelled in the NSA Birth Certificate.",
          style: theme.textTheme.bodyMedium!.copyWith(
            color: ColorTheme.primaryRed,
          ),
        ),

        PrimaryTextField(
          fieldKey: Application.lastNameKey,
          controller: Application.lastName,
          hintText: "Last name",
          label: "Last name",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.firstNameKey,
          controller: Application.firstName,
          hintText: "First name",
          label: "First name",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.middleNameKey,
          controller: Application.middleName,
          hintText: "Middle name",
          label: "Middle name",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.extensionNameKey,
          controller: Application.extensionName,
          hintText: "Extension name e.g. Jr.(if applicable)",
          label: "Extension name e.g. Jr.(if applicable)",
        ),

        PrimaryTextField(
          fieldKey: Application.placeOfBirthKey,
          controller: Application.placeOfBirth,
          hintText: "Place of Birth",
          label: "Place of Birth",
          validator: Commons.forcedTextValidator,

        ),

        PrimaryTextField(
          fieldKey: Application.dateOfBirthKey,
          controller: Application.dateOfBirth,
          hintText: "Enter",
          label: "Date of Birth",
          readOnly: true,
          onTap: () => application.updateBirthDate(context),
        ),

        PrimaryTextField(
          fieldKey: Application.ageKey,
          controller: Application.age,
          hintText: "Enter",
          label: "Age (today)",
          validator: Commons.forcedTextValidator,

        ),

        const SizedBox(height: 12.0),

        CustomDropdown<SelectionOption>(
          initialValue: application.gender,
          value: application.gender,
          label: "Gender",
          hintText: 'Select',
          items: application.genderList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateGender,
          validator: Commons.forcedDropdownValidator,
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

        CustomDropdown<SelectionOption>(
          initialValue: application.isIndigenousPeople,
          value: application.isIndigenousPeople,
          label: "Belong to Indigenous People",
          hintText: 'Select',
          items: application.agreeDisagree.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateIsIndigenousPeople,
          validator: Commons.forcedDropdownValidator,
        ),
        //
        // Visibility(
        //   visible: application.isIndigenousPeople,
        //   child: PrimaryTextField(
        //     fieldKey: Application.indigenousGroupKey,
        //     controller: Application.indigenousGroup,
        //     hintText: "Indigenous Group",
        //     label: "Others (Specify)",
        //   ),
        // ),

        PrimaryTextField(
          fieldKey: Application.motherToungeKey,
          controller: Application.motherTounge,
          hintText: "Enter",
          label: "Mother Tounge",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.otherLanguagesKey,
          controller: Application.otherLanguages,
          hintText: "Enter",
          label: "Other Languages Spoken",
        ),
      ],
    );
  }
}
