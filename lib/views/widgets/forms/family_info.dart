
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/views/widgets/buttons/dropdown.dart';
import 'package:school_management/views/widgets/fields/dropdown.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class FamilyInformationForm extends StatelessWidget {
  const FamilyInformationForm({super.key});

  @override
  Widget build(BuildContext context) {

    final Application application = Provider.of<Application>(context);
    final ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 12.0,),
        Text("C. Family Information",
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12.0),
        CustomDropdown<SelectionOption>(
          initialValue: application.responsible,
          value: application.responsible,
          label: "Person’s mainly responsible for taking care of learner of this school year.",
          hintText: 'Select',
          items: application.responsibleList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateResponsible,
          validator: Commons.forcedDropdownValidator,
        ),

        CustomDropdown<SelectionOption>(
          initialValue: application.status,
          value: application.status,
          label: "Status of Parents",
          hintText: 'Select',
          items: application.statusList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateStatus,
          validator: Commons.forcedDropdownValidator,
        ),
        const SizedBox(height: 12.0),
        PrimaryTextField(
          fieldKey: Application.numberOfBrotherKey,
          controller: Application.numberOfBrother,
          textInput: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          label: "Number of Brothers",
          hintText: "Enter",
          validator: Commons.forcedTextValidator,
        ),
        PrimaryTextField(
          fieldKey: Application.numberOfSisterKey,
          controller: Application.numberOfSister,
          textInput: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          label: "Number of Sisters",
          hintText: "Enter",
          validator: Commons.forcedTextValidator,
        ),
        PrimaryTextField(
          fieldKey: Application.birthOrderKey,
          controller: Application.birthOrder,
          textInput: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          label: "Learners Birth Order Among Siblings",
          hintText: "Enter",
          validator: Commons.forcedTextValidator,
        ),
        const SizedBox(height: 12.0),
        CustomDropdown<SelectionOption>(
          initialValue: application.is4psBeneficiary,
          value: application.is4psBeneficiary,
          label: "Is the family a 4Ps beneficiary",
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
          onChanged: application.updateIs4psBeneficiary,
          validator: Commons.forcedDropdownValidator,
        ),
        Visibility(
          visible: application.is4psBeneficiary?.id == 0,
          child: PrimaryTextField(
            fieldKey: Application.whenBeneficiaryKey,
            controller: Application.whenBeneficiary,
            label: "Since When?",
            hintText: "Enter",
            validator: Commons.forcedTextValidator,
          ),
        ),
        const SizedBox(height: 12.0),
        Text("Information Printed By",
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        PrimaryTextField(
          fieldKey: Application.firstNamePrintedKey,
          controller: Application.firstName,
          hintText: "First name",
          label: "First name",
          validator: Commons.forcedTextValidator,
        ),
        PrimaryTextField(
          fieldKey: Application.lastNamePrintedKey,
          controller: Application.lastNamePrinted,
          hintText: "Last name",
          label: "Last name",
          validator: Commons.forcedTextValidator,
        ),
        PrimaryTextField(
          fieldKey: Application.middleNamePrintedKey,
          controller: Application.middleNamePrinted,
          hintText: "Middle name",
          label: "Middle name",
          validator: Commons.forcedTextValidator,
        ),
        PrimaryTextField(
          fieldKey: Application.learnerRelationKey,
          controller: Application.learnerRelation,
          hintText: "Enter",
          label: "Relationship to Learner (if not learner)",
          validator: Commons.forcedTextValidator,
        ),
        PrimaryTextField(
          fieldKey: Application.dateEnteredKey,
          controller: Application.dateEntered,
          hintText: "Enter",
          label: "Date",
          readOnly: true,
          onTap: () => application.updateDateEntered(context),
        ),

      ],
    );
  }
}
