import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/views/widgets/buttons/dropdown.dart';
import 'package:school_management/views/widgets/fields/dropdown.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class EmergencyForm extends StatelessWidget {
  const EmergencyForm({super.key});

  @override
  Widget build(BuildContext context) {

    final Application application = Provider.of<Application>(context);
    final ThemeData theme = Theme.of(context);

    // final phoneNumberPattern = RegExp(r'^\+639\d{9}$');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 12.0),
        Text("B.2. Communication / Emergency Contact Information",
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12.0),
        CustomDropdown<SelectionOption>(
          initialValue: application.accessComm,
          value: application.accessComm,
          label: "Best Communication Access",
          hintText: 'Select',
          items: application.accessCommList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateAccessComm,
          validator: Commons.forcedDropdownValidator,
        ),

        Visibility(
          visible: application.accessComm != null,
          child: PrimaryTextField(
            fieldKey: Application.phoneNumberKey,
            controller: Application.phoneNumber,
            hintText: "+63XXXXXXXXXX",
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            textInput: TextInputType.phone,
            label: application.accessComm?.id == 0
                ? "Enter your own cellphone number"
                : "Enter the cellphone number of parents/relatives",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "This field is required";
              } else if (value[0] == "0") {
                return "Please start with 63";
              } else {
                return null;
              }
            },
          ),
        ),

        const SizedBox(height: 12.0),
        Text("Emergency Contact: Information",
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
          softWrap: true,
        ),

        PrimaryTextField(
          fieldKey: Application.emergencyFirstNameKey,
          controller: Application.emergencyFirstName,
          hintText: "Enter",
          label: "First Name",
        ),

        PrimaryTextField(
          fieldKey: Application.emergencyMiddleNameKey,
          controller: Application.emergencyMiddleName,
          hintText: "Enter",
          label: "Middle Name",
        ),

        PrimaryTextField(
          fieldKey: Application.emergencyLastNameKey,
          controller: Application.emergencyLastName,
          hintText: "Enter",
          label: "Last Name",
        ),
        const SizedBox(height: 12.0),

        CustomDropdown<SelectionOption>(
          initialValue: application.relationship,
          value: application.relationship,
          label: "Relationship",
          hintText: 'Select',
          items: application.relationshipList.map((SelectionOption option) {
            return SchoolDropdownMenuItem<SelectionOption>(
              value: option,
              label: option.label,
              child: SchoolDropdown(
                option: option,
              ),
            );
          }).toList(),
          onChanged: application.updateRelationship,
          validator: Commons.forcedDropdownValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.emergencyAddressKey,
          controller: Application.emergencyAddress,
          hintText: "Enter",
          label: "Address",
        ),

        PrimaryTextField(
          fieldKey: Application.emergencyPhoneKey,
          controller: Application.emergencyPhone,
          hintText: "Enter",
          label: "Contact Number",
        ),
      ],
    );
  }
}
