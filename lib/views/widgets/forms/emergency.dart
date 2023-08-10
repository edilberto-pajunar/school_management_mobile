import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/views/widgets/buttons/check.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class EmergencyForm extends StatelessWidget {
  const EmergencyForm({super.key});

  @override
  Widget build(BuildContext context) {

    final Application application = Provider.of<Application>(context);
    final ThemeData theme = Theme.of(context);

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

        const Text("B.2.1. Best Communication"),
        const SizedBox(height: 12.0),
        CustomCheckbox(
          value: application.hasPhone,
          onTap: () => application.updateCommunication(false),
          option1: application.hasPhone
              ? "May Sariling Cellphone"
              : "Cellphone ng Magulang",
        ),

        PrimaryTextField(
          fieldKey: Application.phoneNumberKey,
          controller: Application.phoneNumber,
          hintText: "Enter",
          textInput: TextInputType.phone,
          label: application.hasPhone
              ? "No. ng Sariling CP"
              : "No. ng CP ng magulang",
        ),

        const SizedBox(height: 12.0),
        const Text("B.2.2. Emergency Contact: Information / Tatawagan kung may Emergency",
          softWrap: true,
        ),

        PrimaryTextField(
          fieldKey: Application.emergencyNameKey,
          controller: Application.emergencyName,
          hintText: "Enter",
          label: "Pangalan",
        ),

        PrimaryTextField(
          fieldKey: Application.emergencyAddressKey,
          controller: Application.emergencyAddress,
          hintText: "Enter",
          label: "Address",
        ),

        PrimaryTextField(
          fieldKey: Application.relationKey,
          controller: Application.relation,
          hintText: "Enter",
          label: "Relasyon (Magulang, kapatid, o iba pa.)",
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
