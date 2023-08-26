import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/views/widgets/buttons/dropdown.dart';
import 'package:school_management/views/widgets/fields/dropdown.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class SchoolInfoForm extends StatelessWidget {
  const SchoolInfoForm({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final Application application = Provider.of<Application>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text("A. GRADE LEVEL AND SCHOOL INFORMATION",
          softWrap: true,
          style: theme.textTheme.bodyLarge!,
        ),
        const SizedBox(height: 5.0),
        CustomDropdown<SelectionOption>(
          initialValue: application.schoolYear,
          value: application.schoolYear,
          label: "A1. School Year",
          hintText: 'Select',
          items: application.schoolYearList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateSchoolYear,
          validator: Commons.forcedDropdownValidator,
        ),
        Text("Grade Level to Enroll in:",
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        PrimaryTextField(
          controller: TextEditingController(text: application.formLevel),
          label: "Enter",
          readOnly: true,
        ),
        const SizedBox(height: 24.0),

        CustomDropdown<SelectionOption>(
          initialValue: application.lastGradeCompleted,
          value: application.lastGradeCompleted,
          label: "Last Grade Level Completed",
          hintText: 'Select',
          items: application.gradeLevelList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateLastGradeCompleted,
          validator: Commons.forcedDropdownValidator,
        ),

        CustomDropdown<SelectionOption>(
          initialValue: application.lastSchoolYearCompleted,
          value: application.lastSchoolYearCompleted,
          label: "Last School Year Completed",
          hintText: 'Select',
          items: application.schoolYearList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateLastSchoolYearCompleted,
          validator: Commons.forcedDropdownValidator,
        ),

        CustomDropdown<SelectionOption>(
          initialValue: application.residence,
          value: application.residence,
          label: "Residency",
          hintText: 'Select',
          items: application.residenceList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateResidence,
          validator: Commons.forcedDropdownValidator,
        ),

        Text("INFORMATION ON SCHOOL LAST ATTENDED",
          softWrap: true,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        PrimaryTextField(
          fieldKey: Application.schoolNameKey,
          controller: Application.schoolName,
          hintText: "Name of School",
          label: "Name of school",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.schoolIDKey,
          controller: Application.schoolID,
          hintText: "School ID",
          label: "School ID",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.schoolAddressKey,
          controller: Application.schoolAddress,
          hintText: "School Address",
          label: "School Address",
          validator: Commons.forcedTextValidator,
        ),
        const SizedBox(height: 12.0),

        CustomDropdown<SelectionOption>(
          initialValue: application.schoolType,
          value: application.schoolType,
          label: "School Type",
          hintText: 'Select',
          items: application.schoolTypeList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateSchoolType,
          validator: Commons.forcedDropdownValidator,
        ),

        CustomDropdown<SelectionOption>(
          initialValue: application.submitCopyPSA,
          value: application.submitCopyPSA,
          label: "Copy of Certificate (PSA) Submitted",
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
          onChanged: application.updateSubmitCopyPSA,
          validator: Commons.forcedDropdownValidator,
        ),


        PrimaryTextField(
          fieldKey: Application.birthCertNumberKey,
          controller: Application.birthCertNumber,
          hintText: "PSA Birth Certificate No.",
          label: "PSA Birth Certificate No.",
          validator: Commons.forcedTextValidator,
        ),

        const SizedBox(height: 12.0),
        CustomDropdown<SelectionOption>(
          initialValue: application.otherRequirements,
          value: application.otherRequirements,
          label: "Other Enrollment Requirements Submitted as of this Date",
          hintText: 'Select',
          items: application.otherRequirementsList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateOtherRequirements,
          validator: Commons.forcedDropdownValidator,
        ),
      ],
    );
  }
}
