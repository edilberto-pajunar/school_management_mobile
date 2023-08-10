import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/views/widgets/buttons/check.dart';
import 'package:school_management/views/widgets/buttons/radio.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class FamilyInformationForm extends StatelessWidget {
  const FamilyInformationForm({super.key});

  @override
  Widget build(BuildContext context) {

    final Application application = Provider.of<Application>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 12.0,),
        const Text("C. Family Information"),
        const Text("C1. Person’s mainly responsible for taking care of learner of this school year./ "
            "Sino ang nagaasikaso sa mga pangangailangan ng estudyante"
            " (nagbabayad ng mga bayarin, madalas dadalo sa mga meeting, at iba pa.)",
        ),
        Wrap(
          children: application.responsibleList.map((SelectionOption value) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: CustomCheckbox(
                value: application.responsible.contains(value),
                onTap: () {
                  application.updateResponsible(value);
                },
                option1: value.name,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12.0),
        const Text("C2. Status of Parents"),
        Wrap(
          children: application.statusList.map((SelectionOption option) {
            return Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: CustomRadioButton(
                value: application.status == option,
                onTap: () => application.updateStatus(option),
                label: option.name,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12.0),
        PrimaryTextField(
          fieldKey: Application.numberOfBrotherKey,
          controller: Application.numberOfBrother,
          textInput: TextInputType.number,
          label: "C.3 a. Number of Brothers",
          hintText: "Enter",
        ),
        PrimaryTextField(
          fieldKey: Application.numberOfSisterKey,
          controller: Application.numberOfSister,
          textInput: TextInputType.number,
          label: "C.3 b. Number of Sisters",
          hintText: "Enter",
        ),

      ],
    );
  }
}
