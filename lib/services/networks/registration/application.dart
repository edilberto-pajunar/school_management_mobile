import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_management/models/registration/application.dart';
import 'package:school_management/models/registration/emergency_info.dart';
import 'package:school_management/models/registration/personal_info.dart';
import 'package:school_management/models/registration/residence_info.dart';
import 'package:school_management/models/registration/school_info.dart';
import 'package:school_management/models/selection_option.dart';

class Application extends ChangeNotifier {

  bool isLoading = false;

  void showHUD(bool value) {
    isLoading = value;
    notifyListeners();
  }


  final List<SelectionOption> schoolYearList = [
    SelectionOption(id: 0, name: "2023-2024"),
    SelectionOption(id: 1, name: "2022-2023"),
    SelectionOption(id: 2, name: "2021-2022"),
    SelectionOption(id: 3, name: "2020-2021"),
  ];

  SelectionOption? schoolYear;

  void updateSchoolYear(SelectionOption value) {
    schoolYear = value;
    notifyListeners();
  }

  bool assignedLRN = false;

  void updateAssignedLRN(bool? value) {
    assignedLRN = !assignedLRN;
    notifyListeners();
  }

  bool newResidency = false;

  void updateNewResidency(bool? value) {
    newResidency = !newResidency;
    notifyListeners();
  }

  static GlobalKey<FormState> formKey = GlobalKey();

  static TextEditingController gradeToEnroll = TextEditingController();
  static GlobalKey<FormFieldState> gradeToEnrollKey = GlobalKey();

  static TextEditingController lastGradeCompleted = TextEditingController();
  static GlobalKey<FormFieldState> lastGradeCompletedKey = GlobalKey();

  static TextEditingController lastSchoolYearCompleted = TextEditingController();
  static GlobalKey<FormFieldState> lastSchoolYearCompletedKey = GlobalKey();

  static TextEditingController schoolName = TextEditingController();
  static GlobalKey<FormFieldState> schoolNameKey = GlobalKey();

  static TextEditingController schoolID = TextEditingController();
  static GlobalKey<FormFieldState> schoolIDKey = GlobalKey();

  static TextEditingController schoolAddress = TextEditingController();
  static GlobalKey<FormFieldState> schoolAddressKey = GlobalKey();

  bool schoolType = false;

  void updateSchoolType(bool? value) {
    schoolType = !schoolType;
    notifyListeners();
  }

  bool submitCopyPSA = false;

  void updateSubmitCopyPSA(bool? value) {
    submitCopyPSA = !submitCopyPSA;
    notifyListeners();
  }

  bool passForm137 = false;

  void updatePassForm137(bool? value) {
    passForm137 = !passForm137;
    notifyListeners();
  }

  bool passForm138 = false;

  void updatePassForm138(bool? value) {
    passForm138 = !passForm138;
    notifyListeners();
  }

  static TextEditingController birthCertNumber = TextEditingController();
  static GlobalKey<FormFieldState> birthCertNumberKey = GlobalKey();

  static TextEditingController learningReferenceNumber = TextEditingController();
  static GlobalKey<FormFieldState> learningReferenceNumberKey = GlobalKey();

  static TextEditingController lastName = TextEditingController();
  static GlobalKey<FormFieldState> lastNameKey = GlobalKey();

  static TextEditingController firstName = TextEditingController();
  static GlobalKey<FormFieldState> firstNameKey = GlobalKey();

  static TextEditingController middleName = TextEditingController();
  static GlobalKey<FormFieldState> middleNameKey = GlobalKey();

  static TextEditingController extensionName = TextEditingController();
  static GlobalKey<FormFieldState> extensionNameKey = GlobalKey();

  static TextEditingController placeOfBirth = TextEditingController();
  static GlobalKey<FormFieldState> placeOfBirthKey = GlobalKey();

  static TextEditingController dateOfBirth = TextEditingController();
  static GlobalKey<FormFieldState> dateOfBirthKey = GlobalKey();

  Future<void> updateBirthDate(BuildContext context) async {
    DateTime? birthDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 6570)),
      firstDate: DateTime.now().subtract(const Duration(days: 37620)),
      lastDate: DateTime.now().subtract(const Duration(days: 6570)),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    // DateFormat format = DateFormat('MM/dd/yyyy');

    if (birthDate != null) {
      DateTime enteredDate = birthDate;
      // DateTime currentDate = DateTime.now();

      dateOfBirth.text = DateFormat("MM/dd/yyyy").format(enteredDate);
      notifyListeners();
    }

    dateOfBirthKey.currentState!.validate();
  }

  static TextEditingController age = TextEditingController();
  static GlobalKey<FormFieldState> ageKey = GlobalKey();



  SelectionOption? gender;

  final List<SelectionOption> genderList = [
    SelectionOption(id: 0, name: "Male"),
    SelectionOption(id: 1, name: "Female"),
    SelectionOption(id: 2, name: "Others"),
  ];

  void updateGender(SelectionOption? value) {
    gender = value;
    notifyListeners();
  }

  static TextEditingController otherGender = TextEditingController();
  static GlobalKey<FormFieldState> otherGenderKey = GlobalKey();

  bool isIndigenousPeople = false;

  void updateIsIndigenousPeople(bool? value) {
    isIndigenousPeople = !isIndigenousPeople;
    notifyListeners();
  }

  static TextEditingController indigenousGroup = TextEditingController();
  static GlobalKey<FormFieldState> indigenousGroupKey = GlobalKey();

  static TextEditingController motherTounge = TextEditingController();
  static GlobalKey<FormFieldState> motherToungeKey = GlobalKey();

  static TextEditingController otherLanguages = TextEditingController();
  static GlobalKey<FormFieldState> otherLanguagesKey = GlobalKey();

  bool hasPhone = false;

  void updateCommunication(bool value) {
    hasPhone = !hasPhone;
    notifyListeners();
  }

  static TextEditingController phoneNumber = TextEditingController();
  static GlobalKey<FormFieldState> phoneNumberKey = GlobalKey();

  static TextEditingController emergencyName = TextEditingController();
  static GlobalKey<FormFieldState> emergencyNameKey = GlobalKey();

  static TextEditingController emergencyAddress = TextEditingController();
  static GlobalKey<FormFieldState> emergencyAddressKey = GlobalKey();

  static TextEditingController relation = TextEditingController();
  static GlobalKey<FormFieldState> relationKey = GlobalKey();

  static TextEditingController emergencyPhone = TextEditingController();
  static GlobalKey<FormFieldState> emergencyPhoneKey = GlobalKey();

  SelectionOption? currentHousehold;

  final List<SelectionOption> householdList = [
    SelectionOption(id: 0, name: "Own Family/Sariling Pamilya"),
    SelectionOption(id: 1, name: "Relative/Kamag-anak"),
    SelectionOption(id: 2, name: "Non-relative/Hindi kamag-anak"),
  ];

  void updateCurrentHousehold(SelectionOption? value) {
    currentHousehold = value;
    notifyListeners();
  }

  static TextEditingController address = TextEditingController();
  static GlobalKey<FormFieldState> addressKey = GlobalKey();

  static TextEditingController barangay = TextEditingController();
  static GlobalKey<FormFieldState> barangayKey = GlobalKey();

  static TextEditingController city = TextEditingController();
  static GlobalKey<FormFieldState> cityKey = GlobalKey();

  static TextEditingController province = TextEditingController();
  static GlobalKey<FormFieldState> provinceKey = GlobalKey();

  static TextEditingController region = TextEditingController();
  static GlobalKey<FormFieldState> regionKey = GlobalKey();

  static TextEditingController familyAddress = TextEditingController();
  static GlobalKey<FormFieldState> familyAddressKey = GlobalKey();

  static TextEditingController familyBarangay = TextEditingController();
  static GlobalKey<FormFieldState> familyBarangayKey = GlobalKey();

  static TextEditingController familyCity = TextEditingController();
  static GlobalKey<FormFieldState> familyCityKey = GlobalKey();

  static TextEditingController familyProvince = TextEditingController();
  static GlobalKey<FormFieldState> familyProvinceKey = GlobalKey();

  static TextEditingController familyRegion = TextEditingController();
  static GlobalKey<FormFieldState> familyRegionKey = GlobalKey();

  final List<SelectionOption> responsibleList = [
    SelectionOption(id: 0, name: "Both Parents / Ama at Ina"),
    SelectionOption(id: 1, name: "Father / Ama"),
    SelectionOption(id: 2, name: "Mother / Ina"),
    SelectionOption(id: 3, name: "Brothers / Kuya"),
    SelectionOption(id: 4, name: "Sisters / Ate"),
    SelectionOption(id: 5, name: "Uncles / Tiyo"),
    SelectionOption(id: 6, name: "Aunts / Tiya"),
    SelectionOption(id: 7, name: "Grandfather / Lolo"),
    SelectionOption(id: 8, name: "Grandmother / Lola"),
    SelectionOption(id: 9, name: "Others"),
  ];

  List<SelectionOption> responsible = [];

  void updateResponsible(SelectionOption value) {
    if (!responsible.contains(value)) {
      responsible.add(value);
    } else {
      responsible.remove(value);
    }
    notifyListeners();
  }
  
  final List<SelectionOption> statusList = [
    SelectionOption(id: 0, name: "Married & living together"),
    SelectionOption(id: 1, name: "Married but father is working elsewhere"),
    SelectionOption(id: 1, name: "Married but mother is working elsewhere"),
    SelectionOption(id: 2, name: "Separated/Hiwalay"),
    SelectionOption(id: 3, name: "Father is deceased / Pumanaw na ang ama"),
    SelectionOption(id: 3, name: "Mother is deceased / Pumanaw na ang ina"),
    SelectionOption(id: 4, name: "Both parents are deceased"),
    SelectionOption(id: 4, name: "Other / unclear"),
  ];

  SelectionOption? status;

  void updateStatus(SelectionOption? option) {
    status = option;
    notifyListeners();
  }

  static TextEditingController numberOfBrother = TextEditingController();
  static GlobalKey<FormFieldState> numberOfBrotherKey = GlobalKey();

  static TextEditingController numberOfSister = TextEditingController();
  static GlobalKey<FormFieldState> numberOfSisterKey = GlobalKey();

  final FirebaseFirestore db = FirebaseFirestore.instance;

  SchoolInfo get getSchoolInfo {
    final SchoolInfo schoolInfo = SchoolInfo(
        schoolYear: schoolYear!.name,
        lrnAssigned: assignedLRN,
        residency: newResidency ? "New" : "Returning",
        gradeToEnroll: gradeToEnroll.text,
        lastGradeCompleted: lastGradeCompleted.text,
        lastSchoolYear: lastSchoolYearCompleted.text,
        nameOfSchool: schoolName.text,
        schoolId: schoolID.text,
        schoolAddress: schoolAddress.text,
        schoolType: schoolType ? "Public" : "Private",
        isPsaSubmitted: submitCopyPSA,
        otherRequirements: "Form 137",
    );

    return schoolInfo;
  }

  PersonalInfo get getPersonalInfo {
    final PersonalInfo personalInfo = PersonalInfo(
      lrn: learningReferenceNumber.text,
      lastName: lastName.text,
      firstName: firstName.text,
      middleName: middleName.text,
      extensionName: extensionName.text,
      placeOfBirth: placeOfBirth.text,
      dateOfBirth: dateOfBirth.text,
      age: age.text,
      gender: gender!.name,
      motherTounge: motherTounge.text,
      otherLanguage: otherLanguages.text,
    );

    return personalInfo;
  }

  EmergencyInfo get getEmergencyInfo {
    final EmergencyInfo emergencyInfo = EmergencyInfo(
      communication: hasPhone ? "May Sariling Cellphone" : "Cellphone ng Magulang",
      number: phoneNumber.text,
      emergencyPerson: emergencyName.text,
      emergencyAddress: emergencyAddress.text,
      relasyon: relation.text,
      contactNumber: emergencyPhone.text,
    );

    return emergencyInfo;
  }

  ResidenceInfo get getResidenceInfo {
    final ResidenceInfo residenceInfo = ResidenceInfo(
      household: currentHousehold!.name,
      currentAddress: Address(
          addres: address.text,
          barangay: barangay.text,
          city: city.text,
          province: province.text,
          region: region.text,
      ),
      familyAddress:  Address(
        addres: familyAddress.text,
        barangay: familyBarangay.text,
        city: familyCity.text,
        province: familyProvince.text,
        region: familyRegion.text,
      ),
      familyInfo: responsible.map((e) => e.name).toList(),
      statusOfParents: status!.name,
      numberOfBrothers: numberOfBrother.text,
      numberOfSisters: numberOfSister.text,
    );

    return residenceInfo;
  }

  Future<void> submitApplicationForm(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    showHUD(true);

    try {
      final ApplicationInfo applicationInfo = ApplicationInfo(
        schoolInfo: getSchoolInfo,
        personalInfo: getPersonalInfo,
        emergencyInfo: getEmergencyInfo,
        residenceInfo: getResidenceInfo,
      );

      await db.collection("forms").doc().set(applicationInfo.toJson());
      // clearForm();
      showHUD(false);

    } catch (e) {
      showHUD(false);
      await showDialog(context: context, builder: (context) {
        return AlertDialog(
          content: Text("Please enter all valid requirements",
            style: theme.textTheme.bodyMedium!.copyWith(
              color: Colors.red,
            ),
          ),
        );
      });
      throw "Error: ${e}";
    }

  }

  void clearForm() {
    schoolYear = null;
    assignedLRN = false;
    newResidency = false;
    gradeToEnroll.clear();
    lastGradeCompleted.clear();
    lastSchoolYearCompleted.clear();
    schoolName.clear();
    schoolID.clear();
    schoolAddress.clear();
    schoolType = false;
    submitCopyPSA = false;
    birthCertNumber.clear();
    passForm137 = false;
    passForm138 = false;
    learningReferenceNumber.clear();
    lastName.clear();
    firstName.clear();
    middleName.clear();
    extensionName.clear();
    placeOfBirth.clear();
    dateOfBirth.clear();
    age.clear();
    gender = null;
    isIndigenousPeople = false;
    indigenousGroup.clear();
    motherTounge.clear();
    otherLanguages.clear();
    hasPhone = false;
    phoneNumber.clear();
    emergencyName.clear();
    emergencyAddress.clear();
    relation.clear();
    emergencyPhone.clear();
    currentHousehold = null;
    address.clear();
    barangay.clear();
    city.clear();
    province.clear();
    region.clear();
    familyAddress.clear();
    familyBarangay.clear();
    familyCity.clear();
    familyRegion.clear();
    responsible = [];
    status = null;
    numberOfBrother.clear();
    numberOfSister.clear();
    notifyListeners();
  }

}