import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:school_management/services/networks/registration/application.dart';
import 'package:school_management/views/widgets/buttons/radio.dart';
import 'package:school_management/views/widgets/fields/primary.dart';

class ResidenceForm extends StatelessWidget {
  const ResidenceForm({super.key});

  @override
  Widget build(BuildContext context) {

    final ThemeData theme = Theme.of(context);
    final Application application = Provider.of<Application>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 12.0),
        Text("B.3. Residence",
          style: theme.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                child: const Text("B.3.1. Household Currently living in",)),
            const SizedBox(width: 12.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: application.householdList.map((SelectionOption value) {
                return Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: CustomRadioButton(
                    value: application.currentHousehold == value,
                    onTap: () => application.updateCurrentHousehold(value),
                    label: value.name,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
        const SizedBox(height: 12.0),
        const Text("B.3.2 Current Residence / Kasalukuyang tinitirhan (sa taong ito).",
        ),

        PrimaryTextField(
          fieldKey: Application.addressKey,
          controller: Application.address,
          hintText: "Address",
          label: "a. House Number & Street of Barangay Zone/Purok",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.barangayKey,
          controller: Application.barangay,
          hintText: "Barangay",
          label: "b. Barangay",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.cityKey,
          controller: Application.city,
          hintText: "City",
          label: "c. City/Municipality",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.provinceKey,
          controller: Application.province,
          hintText: "Province",
          label: "d. Province",
          validator: Commons.forcedTextValidator,
        ),

        PrimaryTextField(
          fieldKey: Application.regionKey,
          controller: Application.region,
          hintText: "Region",
          label: "e. Region",
          validator: Commons.forcedTextValidator,
        ),

        const SizedBox(height: 12.0),

        const Text("B.3.3 Address of Family, if not living in the household of the family / "
            "Tirahan ng pamilya, kung hindi nakatira ngayon na kasama ang pamilya",
        ),

        PrimaryTextField(
          fieldKey: Application.familyAddressKey,
          controller: Application.familyAddress,
          hintText: "Address",
          label: "a. House Number & Street of Barangay Zone/Purok",
        ),

        PrimaryTextField(
          fieldKey: Application.familyBarangayKey,
          controller: Application.familyBarangay,
          hintText: "Barangay",
          label: "b. Barangay",
        ),

        PrimaryTextField(
          fieldKey: Application.familyCityKey,
          controller: Application.familyCity,
          hintText: "City",
          label: "c. City/Municipality",
        ),

        PrimaryTextField(
          fieldKey: Application.familyProvinceKey,
          controller: Application.familyProvince,
          hintText: "Province",
          label: "d. Province",
        ),

        PrimaryTextField(
          fieldKey: Application.familyRegionKey,
          controller: Application.familyRegion,
          hintText: "Region",
          label: "e. Region",
        ),
      ],
    );
  }
}
