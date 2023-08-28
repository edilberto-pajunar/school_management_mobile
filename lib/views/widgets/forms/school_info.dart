import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/views/widgets/buttons/dropdown.dart';
import 'package:school_management/views/widgets/fields/dropdown.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class SchoolInfoForm extends StatefulWidget {
  const SchoolInfoForm({
    this.isGrade7 = false,
    this.continueJunior = false,
    this.newSenior = false,
    this.otherSchool = false,
    this.continueSenior = false,
    super.key,
  });

  final bool isGrade7;
  final bool continueJunior;
  final bool newSenior;
  final bool otherSchool;
  final bool continueSenior;

  @override
  State<SchoolInfoForm> createState() => _SchoolInfoFormState();
}

class _SchoolInfoFormState extends State<SchoolInfoForm> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Application application = Provider.of<Application>(context, listen: false);
      if (widget.isGrade7) {
        application.updateGradeToEnroll(application.juniorGradeList[0]);
      }

      if (widget.continueJunior) {
        application.updateResidence(application.otherResidenceList[1]);
        Application.schoolName.text = "St.Jude Agro Industrial Secondary School";
        Application.schoolID.text = "500844";
        Application.schoolAddress.text = "Topas Proper Nabua, Camarines Sur";
        application.updateSchoolType(application.schoolTypeList[1]);
      }
      
      if (widget.newSenior) {
        application.updateGradeToEnroll(application.seniorGradeList[0]);
        application.updateLastGradeCompleted(application.seniorGradeList.last);
        application.updateResidence(application.residenceList.last);
        Application.schoolName.text = "St.Jude Agro Industrial Secondary School";
        Application.schoolID.text = "500844";
        Application.schoolAddress.text = "Topas Proper Nabua, Camarines Sur";
        application.updateSchoolType(application.schoolTypeList[1]);
        Application.track.text = "Academic";
      }

      if (widget.otherSchool) {
        application.updateResidence(application.residenceList[0]);
        Application.track.text = "Academic";
      }

      if (widget.continueSenior) {
        application.updateGradeToEnroll(application.seniorGradeList[1]);
        application.updateLastGradeCompleted(application.seniorGradeList.first);
        application.updateResidence(application.residenceList[1]);
        Application.track.text = "Academic";
      }
      
    });
  }

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

        CustomDropdown<SelectionOption>(
          initialValue: application.gradeToEnroll,
          value: application.gradeToEnroll,
          enabled: widget.isGrade7 ? false : !widget.newSenior,
          label: "Grade Level to Enroll in:",
          hintText: 'Select',
          items: widget.newSenior || widget.continueSenior
            ? application.seniorGradeList.map((SelectionOption option) {
                return SchoolDropdownMenuItem<SelectionOption>(
                  value: option,
                  label: option.label,
                  child: SchoolDropdown(
                    option: option,
                    ),
                  );
              }).toList()
            : application.juniorGradeList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateGradeToEnroll,
          validator: Commons.forcedDropdownValidator,
        ),

        CustomDropdown<SelectionOption>(
          initialValue: application.lastGradeCompleted,
          value: application.lastGradeCompleted,
          label: "Last Grade Level Completed",
          enabled: !widget.newSenior,
          hintText: 'Select',
          items: widget.newSenior || widget.continueSenior
              ? application.seniorGradeList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList()
              : application.juniorGradeList.map((SelectionOption option) {
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
          items: widget.continueJunior
            ? application.otherResidenceList.map((SelectionOption option) {
                return SchoolDropdownMenuItem<SelectionOption>(
                  value: option,
                  label: option.label,
                child: SchoolDropdown(
                      option: option,
                    ),
                  );
                }).toList()
            : application.residenceList.map((SelectionOption option) {
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

        Text("INFORMATION ON SCHOOL LAffST ATTENDED",
          softWrap: true,
          style: theme.textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),

        PrimaryTextField(
          fieldKey: Application.schoolNameKey,
          controller: Application.schoolName,
          readOnly: widget.continueJunior,
          hintText: "Name of School",
          label: "Name of school",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.schoolIDKey,
          controller: Application.schoolID,
          readOnly: widget.continueJunior,
          hintText: "School ID",
          label: "School ID",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.schoolAddressKey,
          controller: Application.schoolAddress,
          readOnly: widget.continueJunior,
          hintText: "School Address",
          label: "School Address",
          validator: Commons.forcedTextValidator,
        ),
        const SizedBox(height: 12.0),

        CustomDropdown<SelectionOption>(
          initialValue: application.schoolType,
          value: application.schoolType,
          enabled: !widget.continueJunior,
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

        Visibility(
          visible: widget.newSenior || widget.otherSchool,
          child: Column(
            children: [
              CustomDropdown<SelectionOption>(
                initialValue: application.semester,
                value: application.semester,
                label: "Semester",
                hintText: 'Select',
                items: application.semesterList.map((SelectionOption option) {
                  return SchoolDropdownMenuItem<SelectionOption>(
                    value: option,
                    label: option.label,
                    child: SchoolDropdown(
                      option: option,
                    ),
                  );
                }).toList(),
                onChanged: application.updateSemester,
                validator: Commons.forcedDropdownValidator,
              ),

              PrimaryTextField(
                controller: Application.track,
                label: "Track",
                validator: Commons.forcedTextValidator,
              ),
              const SizedBox(height: 12.0),

              CustomDropdown<SelectionOption>(
                initialValue: application.strand,
                value: application.strand,
                label: "Strand",
                hintText: 'Select',
                items: application.strandList.map((SelectionOption option) {
                  return SchoolDropdownMenuItem<SelectionOption>(
                    value: option,
                    label: option.label,
                    child: SchoolDropdown(
                      option: option,
                    ),
                  );
                }).toList(),
                onChanged: application.updateStrand,
                validator: Commons.forcedDropdownValidator,
              ),
            ],
          ),
        ),


      ],
    );
  }
}
