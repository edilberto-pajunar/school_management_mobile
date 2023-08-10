import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/views/widgets/buttons/check.dart';
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
          label: "A1. School Year",
          value: application.schoolYear,
          onChanged: (value) {},
          items: application.schoolYearList.map((SelectionOption option) {
            return DropdownMenuItem<SelectionOption>(
              value: option,
              onTap: () => application.updateSchoolYear(option),
              child: Text(option.name,
                style: theme.textTheme.bodyMedium,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12.0),
        Row(
          children: [
            const Text("A2. With LRN Assigned"),
            const SizedBox(width: 12.0),
            CustomCheckbox(
              value: application.assignedLRN,
              onTap: () => application.updateAssignedLRN(false),
              option1: application.assignedLRN ? "Yes" : "No",
            ),
          ],
        ),

        const SizedBox(height: 12.0),
        Row(
          children: [
            const Text("A3. Residency"),
            const SizedBox(width: 12.0),
            CustomCheckbox(
              value: application.newResidency,
              onTap: () => application.updateNewResidency(false),
              option1: application.newResidency
                  ? "New"
                  : "Returning",
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child:  PrimaryTextField(
                prefixText: "Gr.",
                fieldKey: Application.gradeToEnrollKey,
                controller: Application.gradeToEnroll,
                label: "A4. Grade Level to Enroll in",
                validator: Commons.forcedTextValidator,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child:  PrimaryTextField(
                fieldKey: Application.lastGradeCompletedKey,
                controller: Application.lastGradeCompleted,
                prefixText: "Gr.",
                label: "A5. Last Grade Level Completed",
                validator: Commons.forcedTextValidator,
              ),
            ),

          ],
        ),
        PrimaryTextField(
          fieldKey: Application.lastSchoolYearCompletedKey,
          controller: Application.lastSchoolYearCompleted,
          hintText: "School Year",
          label: "A6. Last School Year Completed",
          textInput: TextInputType.number,
          validator: Commons.forcedTextValidator,
        ),
        const SizedBox(height: 24.0),

        Text("INFORMATION ON SCHOOL LAST ATTENDED",
          softWrap: true,
          style: theme.textTheme.bodyLarge!,
        ),

        PrimaryTextField(
          fieldKey: Application.schoolNameKey,
          controller: Application.schoolName,
          hintText: "",
          label: "A7. Name of school",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.schoolIDKey,
          controller: Application.schoolID,
          hintText: "",
          label: "A8. School ID",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.schoolAddressKey,
          controller: Application.schoolAddress,
          hintText: "",
          label: "A9. School Address",
          validator: Commons.forcedTextValidator,
        ),

        const SizedBox(height: 12.0),
        Row(
          children: [
            const Text("A10. School Type"),
            const SizedBox(width: 12.0),
            CustomCheckbox(
              value: application.schoolType,
              onTap: () => application.updateSchoolType(false),
              option1: application.schoolType
                  ? "Public"
                  : "Private",
            ),
          ],
        ),

        const SizedBox(height: 12.0),
        Row(
          children: [
            const Expanded(
              child: Text("A11 a. Copy of Birth Certificate (PSA) Submitted?"),
            ),
            const SizedBox(width: 12.0),
            CustomCheckbox(
              value: application.submitCopyPSA,
              onTap: () => application.updateSubmitCopyPSA(false),
              option1: application.submitCopyPSA
                  ? "Yes"
                  : "No",
            ),
          ],
        ),

        PrimaryTextField(
          fieldKey: Application.birthCertNumberKey,
          controller: Application.birthCertNumber,
          hintText: "Enter",
          label: "B.1.b. PSA Birth Certificate No.",
          validator: Commons.forcedTextValidator,
        ),

        const SizedBox(height: 12.0),
        const Text("A11 b. Other Enrolment Requirements Submitted as of this date?"),
        const SizedBox(height: 12.0),
        Row(
          children: [
            CustomCheckbox(
              value: application.passForm137,
              onTap: () => application.updatePassForm137(false),
              option1: "Form 137",
            ),
            const SizedBox(width: 24.0),
            CustomCheckbox(
              value: application.passForm138,
              onTap: () => application.updatePassForm138(false),
              option1: "Form 138",
            ),
          ],
        ),
      ],
    );
  }
}
