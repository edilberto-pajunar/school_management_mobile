import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_management/models/registration/application.dart';
import 'package:school_management/models/registration/emergency_info.dart';
import 'package:school_management/models/registration/personal_info.dart';
import 'package:school_management/models/registration/residence_info.dart';
import 'package:school_management/models/registration/school_info.dart';
import 'package:school_management/models/selection_option.dart';
import 'package:school_management/models/student/new_subject.dart';
import 'package:school_management/services/networks/commons.dart';
import 'package:http/http.dart' as http;
import 'package:school_management/values/strings/api/key.dart';

class Application extends ChangeNotifier {

  bool isLoading = false;

  void showHUD(bool value) {
    isLoading = value;
    notifyListeners();
  }

  // String? formLevel;
  //
  // void updateFormLevel(String? value) {
  //   formLevel = value;
  //   notifyListeners();
  // }


  final List<SelectionOption> schoolYearList = const [
    SelectionOption(id: 0, label: "2023-2024"),
    SelectionOption(id: 1, label: "2024-2025"),
    SelectionOption(id: 2, label: "2025-2026"),
    SelectionOption(id: 3, label: "2026-2027"),
    SelectionOption(id: 4, label: "2027-2028"),
    SelectionOption(id: 5, label: "2028-2029"),
    SelectionOption(id: 6, label: "2029-2030"),
    SelectionOption(id: 7, label: "2030-2031"),
    SelectionOption(id: 8, label: "2031-2032"),
    SelectionOption(id: 9, label: "2032-2033"),
  ];

  SelectionOption? schoolYear;

  void updateSchoolYear(SelectionOption? value) {
    schoolYear = value;
    notifyListeners();
  }

  final List<SelectionOption> juniorGradeList = const [
    SelectionOption(id: 0, label: "Grade 7"),
    SelectionOption(id: 1, label: "Grade 8"),
    SelectionOption(id: 2, label: "Grade 9"),
    SelectionOption(id: 3, label: "Grade 10"),
  ];

  final List<SelectionOption> seniorGradeList = const [
    SelectionOption(id: 0, label: "Grade 11"),
    SelectionOption(id: 1, label: "Grade 12"),
    SelectionOption(id: 2, label: "Grade 9"),
    SelectionOption(id: 3, label: "Grade 10"),
  ];

  SelectionOption? gradeToEnroll;

  void updateGradeToEnroll(SelectionOption? value) {
    gradeToEnroll = value;
    notifyListeners();
  }

  // SelectionOption? assignedLRN;
  //
  // void updateAssignedLRN(SelectionOption? value) {
  //   assignedLRN = value;
  //   notifyListeners();
  // }

  bool newResidency = false;

  void updateNewResidency(bool? value) {
    newResidency = !newResidency;
    notifyListeners();
  }

  static GlobalKey<FormState> formKey = GlobalKey();

  // static TextEditingController gradeToEnroll = TextEditingController();
  // static GlobalKey<FormFieldState> gradeToEnrollKey = GlobalKey();

  final List<SelectionOption> gradeLevelList = const [
    SelectionOption(id: 0, label: "Grade 1"),
    SelectionOption(id: 1, label: "Grade 2"),
    SelectionOption(id: 2, label: "Grade 3"),
    SelectionOption(id: 3, label: "Grade 4"),
    SelectionOption(id: 4, label: "Grade 5"),
    SelectionOption(id: 5, label: "Grade 6"),
    SelectionOption(id: 6, label: "Grade 7"),
  ];

  SelectionOption? lastGradeCompleted;

  void updateLastGradeCompleted(SelectionOption? value) {
    lastGradeCompleted = value;
    notifyListeners();
  }

  // static TextEditingController lastGradeCompleted = TextEditingController();
  // static GlobalKey<FormFieldState> lastGradeCompletedKey = GlobalKey();

  // static TextEditingController lastSchoolYearCompleted = TextEditingController();
  // static GlobalKey<FormFieldState> lastSchoolYearCompletedKey = GlobalKey();

  SelectionOption? lastSchoolYearCompleted;

  void updateLastSchoolYearCompleted(SelectionOption? value) {
    lastSchoolYearCompleted = value;
    notifyListeners();
  }

  final List<SelectionOption> residenceList = const [
    SelectionOption(id: 0, label: "New"),
    SelectionOption(id: 1, label: "Returning"),
  ];

  final List<SelectionOption> otherResidenceList = const [
    SelectionOption(id: 0, label: "New"),
    SelectionOption(id: 1, label: "Continouing"),
  ];

  SelectionOption? residence;

  void updateResidence(SelectionOption? value) {
    residence = value;
    notifyListeners();
  }

  static TextEditingController schoolName = TextEditingController();
  static GlobalKey<FormFieldState> schoolNameKey = GlobalKey();

  static TextEditingController schoolID = TextEditingController();
  static GlobalKey<FormFieldState> schoolIDKey = GlobalKey();

  final List<SelectionOption> schoolTypeList = const [
    SelectionOption(id: 0, label: "Public School"),
    SelectionOption(id: 1, label: "Private School"),
  ];

  SelectionOption? schoolType;

  void updateSchoolType(SelectionOption? value) {
    schoolType = value;
    notifyListeners();
  }

  static TextEditingController schoolAddress = TextEditingController();
  static GlobalKey<FormFieldState> schoolAddressKey = GlobalKey();
  //
  // bool schoolType = false;
  //
  // void updateSchoolType(bool? value) {
  //   schoolType = !schoolType;
  //   notifyListeners();
  // }

  final List<SelectionOption> agreeDisagree = const [
    SelectionOption(id: 0, label: "Yes"),
    SelectionOption(id: 1, label: "No"),
  ];

  SelectionOption? submitCopyPSA;

  void updateSubmitCopyPSA(SelectionOption? value) {
    submitCopyPSA = value;
    notifyListeners();
  }

  // bool submitCopyPSA = false;
  //
  // void updateSubmitCopyPSA(bool? value) {
  //   submitCopyPSA = !submitCopyPSA;
  //   notifyListeners();
  // }
  final List<SelectionOption> otherRequirementsList = const [
    SelectionOption(id: 0, label: "Form 138"),
    SelectionOption(id: 1, label: "Form 137"),
  ];

  SelectionOption? otherRequirements;

  void updateOtherRequirements(SelectionOption? value) {
    otherRequirements = value;
    notifyListeners();
  }

  // bool passForm137 = false;
  //
  // void updatePassForm137(bool? value) {
  //   passForm137 = !passForm137;
  //   notifyListeners();
  // }
  //
  // bool passForm138 = false;
  //
  // void updatePassForm138(bool? value) {
  //   passForm138 = !passForm138;
  //   notifyListeners();
  // }

  final List<SelectionOption> semesterList = const [
    SelectionOption(id: 0, label: "1st Semester"),
    SelectionOption(id: 1, label: "2nd Semester"),
  ];

  SelectionOption? semester;

  void updateSemester(SelectionOption? value) {
    semester = value;
    notifyListeners();
  }

  static TextEditingController track = TextEditingController();
  static GlobalKey<FormFieldState> trackKey = GlobalKey();

  final List<SelectionOption> strandList = const [
    SelectionOption(id: 0, label: "GAS(General Academic Strand)"),
    SelectionOption(id: 1, label: "STEM(Science, Technology, Engineering and Mathematics)"),
    SelectionOption(id: 2, label: "HUMMS(Humanities and Social Sciences)"),
  ];

  SelectionOption? strand;

  void updateStrand(SelectionOption? value) {
    strand = value;
    notifyListeners();
  }

  static TextEditingController birthCertNumber = TextEditingController();
  static GlobalKey<FormFieldState> birthCertNumberKey = GlobalKey();

  SelectionOption? hasLRN;

  void updateHasLRN(SelectionOption? value) {
    hasLRN = value;
    notifyListeners();
  }

  static TextEditingController learningReferenceNumber = TextEditingController();
  static GlobalKey<FormFieldState> learningReferenceNumberKey = GlobalKey();

  static TextEditingController lastName= TextEditingController();
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

  DateTime? birthDay;

  Future<void> updateBirthDate(BuildContext context) async {
    DateTime? birthDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 50000)),
      lastDate: DateTime.now(),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
    );

    // DateFormat format = DateFormat('MM/dd/yyyy');

    if (birthDate != null) {
      DateTime enteredDate = birthDate;
      birthDay = birthDate;
      // DateTime currentDate = DateTime.now();

      dateOfBirth.text = DateFormat("MM/dd/yyyy").format(enteredDate);
      notifyListeners();
    }

    dateOfBirthKey.currentState!.validate();
  }

  static TextEditingController age = TextEditingController();
  static GlobalKey<FormFieldState> ageKey = GlobalKey();



  SelectionOption? gender;

  final List<SelectionOption> genderList = const [
    SelectionOption(id: 0, label: "Male"),
    SelectionOption(id: 1, label: "Female"),
  ];

  void updateGender(SelectionOption? value) {
    gender = value;
    notifyListeners();
  }

  static TextEditingController otherGender = TextEditingController();
  static GlobalKey<FormFieldState> otherGenderKey = GlobalKey();

  SelectionOption? isIndigenousPeople;

  void updateIsIndigenousPeople(SelectionOption? value) {
    isIndigenousPeople = value;
    notifyListeners();
  }

  static TextEditingController indigenousGroup = TextEditingController();
  static GlobalKey<FormFieldState> indigenousGroupKey = GlobalKey();

  static TextEditingController motherTounge = TextEditingController();
  static GlobalKey<FormFieldState> motherToungeKey = GlobalKey();

  static TextEditingController otherLanguages = TextEditingController();
  static GlobalKey<FormFieldState> otherLanguagesKey = GlobalKey();

  SelectionOption? accessComm;

  final List<SelectionOption> accessCommList = const [
    SelectionOption(id: 0, label: "Own Mobile Phone"),
    SelectionOption(id: 1, label: "Parents/relative Mobile Phone"),
  ];

  void updateAccessComm(SelectionOption? value) {
    accessComm = value;
    notifyListeners();
  }


  bool hasPhone = false;

  void updateCommunication(bool value) {
    hasPhone = !hasPhone;
    notifyListeners();
  }

  static TextEditingController phoneNumber = TextEditingController();
  static GlobalKey<FormFieldState> phoneNumberKey = GlobalKey();

  static TextEditingController emergencyFirstName = TextEditingController();
  static GlobalKey<FormFieldState> emergencyFirstNameKey = GlobalKey();

  static TextEditingController emergencyMiddleName = TextEditingController();
  static GlobalKey<FormFieldState> emergencyMiddleNameKey = GlobalKey();

  static TextEditingController emergencyLastName = TextEditingController();
  static GlobalKey<FormFieldState> emergencyLastNameKey = GlobalKey();

  static TextEditingController emergencyAddress = TextEditingController();
  static GlobalKey<FormFieldState> emergencyAddressKey = GlobalKey();

  SelectionOption? relationship;

  final List<SelectionOption> relationshipList = const [
    SelectionOption(id: 0, label: "Mother"),
    SelectionOption(id: 1, label: "Father"),
    SelectionOption(id: 1, label: "Daughter"),
    SelectionOption(id: 1, label: "Son"),
    SelectionOption(id: 1, label: "Aunt"),
    SelectionOption(id: 1, label: "Uncle"),
    SelectionOption(id: 1, label: "Cousin"),
    SelectionOption(id: 1, label: "Sister"),
    SelectionOption(id: 1, label: "Brother"),
    SelectionOption(id: 1, label: "Grandmother"),
    SelectionOption(id: 1, label: "Grandfather"),
    SelectionOption(id: 1, label: "Granddaughter"),
    SelectionOption(id: 1, label: "Grandson"),
    SelectionOption(id: 1, label: "Niece"),
    SelectionOption(id: 1, label: "Nephew"),
    SelectionOption(id: 1, label: "Half-Sister"),
    SelectionOption(id: 1, label: "Half-Brother"),
    SelectionOption(id: 1, label: "Step-Mother"),
    SelectionOption(id: 1, label: "Step-Father"),
    SelectionOption(id: 1, label: "Step-Daughter"),
    SelectionOption(id: 1, label: "Step-Son"),
    SelectionOption(id: 1, label: "In-Law"),
  ];

  void updateRelationship(SelectionOption? value) {
    relationship = value;
    notifyListeners();
  }

  static TextEditingController emergencyPhone = TextEditingController();
  static GlobalKey<FormFieldState> emergencyPhoneKey = GlobalKey();

  SelectionOption? currentHousehold;

  final List<SelectionOption> householdList = const [
    SelectionOption(id: 0, label: "Own Family/Sariling Pamilya"),
    SelectionOption(id: 1, label: "Relative/Kamag-anak"),
    SelectionOption(id: 2, label: "Non-relative/Hindi kamag-anak"),
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

  final List<SelectionOption> responsibleList = const [
    SelectionOption(id: 0, label: "Both Parents / Ama at Ina"),
    SelectionOption(id: 1, label: "Father / Ama"),
    SelectionOption(id: 2, label: "Mother / Ina"),
    SelectionOption(id: 3, label: "Brothers / Kuya"),
    SelectionOption(id: 4, label: "Sisters / Ate"),
    SelectionOption(id: 5, label: "Uncles / Tiyo"),
    SelectionOption(id: 6, label: "Aunts / Tiya"),
    SelectionOption(id: 7, label: "Grandfather / Lolo"),
    SelectionOption(id: 8, label: "Grandmother / Lola"),
    SelectionOption(id: 9, label: "Others"),
  ];

  SelectionOption? responsible;

  void updateResponsible(SelectionOption? value) {
    responsible = value;
    notifyListeners();
  }

  final List<SelectionOption> statusList = const [
    SelectionOption(id: 0, label: "Married & living together"),
    SelectionOption(id: 1, label: "Married but father is working elsewhere"),
    SelectionOption(id: 1, label: "Married but mother is working elsewhere"),
    SelectionOption(id: 2, label: "Separated/Hiwalay"),
    SelectionOption(id: 3, label: "Father is deceased / Pumanaw na ang ama"),
    SelectionOption(id: 3, label: "Mother is deceased / Pumanaw na ang ina"),
    SelectionOption(id: 4, label: "Both parents are deceased"),
    SelectionOption(id: 4, label: "Other / unclear"),
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

  static TextEditingController birthOrder = TextEditingController();
  static GlobalKey<FormFieldState> birthOrderKey = GlobalKey();

  SelectionOption? is4psBeneficiary;

  void updateIs4psBeneficiary(SelectionOption? option) {
    is4psBeneficiary = option;
    notifyListeners();
  }

  static TextEditingController whenBeneficiary = TextEditingController();
  static GlobalKey<FormFieldState> whenBeneficiaryKey = GlobalKey();

  static TextEditingController lastNamePrinted = TextEditingController();
  static GlobalKey<FormFieldState> lastNamePrintedKey = GlobalKey();

  static TextEditingController firstNamePrinted = TextEditingController();
  static GlobalKey<FormFieldState> firstNamePrintedKey = GlobalKey();

  static TextEditingController middleNamePrinted = TextEditingController();
  static GlobalKey<FormFieldState> middleNamePrintedKey = GlobalKey();

  static TextEditingController learnerRelation = TextEditingController();
  static GlobalKey<FormFieldState> learnerRelationKey = GlobalKey();

  static TextEditingController dateEntered = TextEditingController();
  static GlobalKey<FormFieldState> dateEnteredKey = GlobalKey();

  Future<void> updateDateEntered(BuildContext context) async {
    DateTime? birthDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 50000)),
      lastDate: DateTime.now(),
    );

    // DateFormat format = DateFormat('MM/dd/yyyy');

    if (birthDate != null) {
      DateTime enteredDate = birthDate;
      // DateTime currentDate = DateTime.now();

      dateEntered.text = DateFormat("MM/dd/yyyy").format(enteredDate);
      notifyListeners();
    }

    dateOfBirthKey.currentState!.validate();
  }

  final FirebaseFirestore db = FirebaseFirestore.instance;

  SchoolInfo get getSchoolInfo {
    final SchoolInfo schoolInfo = SchoolInfo(
        schoolYear: schoolYear!.label,
        gradeToEnroll: gradeToEnroll!.label,
        lastGradeCompleted: lastGradeCompleted!.label,
        lastSchoolYear: lastSchoolYearCompleted!.label,
        residency: residence!.label,
        nameOfSchool: schoolName.text,
        schoolId: schoolID.text,
        schoolAddress: schoolAddress.text,
        schoolType: schoolType!.label,
        isPsaSubmitted: submitCopyPSA!.id == 0 ? true : false,
        birthCertificate: birthCertNumber.text,
        otherRequirements: otherRequirements!.label,
        semester: semester?.label,
        track: track.text,
        strand: strand?.label,
    );

    return schoolInfo;
  }

  PersonalInfo get getPersonalInfo {
    final PersonalInfo personalInfo = PersonalInfo(
      hasLrn: hasLRN!.id == 0 ? true : false,
      lrn: learningReferenceNumber.text,
      lastName: lastName.text,
      firstName: firstName.text,
      middleName: middleName.text,
      extensionName: extensionName.text,
      placeOfBirth: placeOfBirth.text,
      dateOfBirth: dateOfBirth.text,
      age: age.text,
      gender: gender!.label,
      isIndigenous: isIndigenousPeople!.id == 0 ? true : false,
      motherTounge: motherTounge.text,
      otherLanguage: otherLanguages.text,
    );

    return personalInfo;
  }

  EmergencyInfo get getEmergencyInfo {
    final EmergencyInfo emergencyInfo = EmergencyInfo(
      communication: hasPhone ? "May Sariling Cellphone" : "Cellphone ng Magulang",
      number: phoneNumber.text,
      emergencyPerson: "${emergencyFirstName.text} ${emergencyMiddleName.text} ${emergencyLastName.text}",
      emergencyAddress: emergencyAddress.text,
      relationship: relationship!.label,
      address: emergencyAddress.text,
      contactNumber: emergencyPhone.text,
    );

    return emergencyInfo;
  }

  ResidenceInfo get getResidenceInfo {
    final ResidenceInfo residenceInfo = ResidenceInfo(
      household: currentHousehold!.label,
      currentAddress: Address(
          address: address.text,
          barangay: barangay.text,
          city: city.text,
          province: province.text,
          region: region.text,
      ),
      familyAddress:  Address(
        address: familyAddress.text,
        barangay: familyBarangay.text,
        city: familyCity.text,
        province: familyProvince.text,
        region: familyRegion.text,
      ),
      familyInfo: responsible!.label,
      statusOfParents: status!.label,
      numberOfBrothers: numberOfBrother.text,
      numberOfSisters: numberOfSister.text,
      is4psBeneficiary: is4psBeneficiary!.id == 0 ? true : false,
      whenBeneficiary: whenBeneficiary.text,
      printedName: "${firstNamePrinted.text} ${middleNamePrinted.text} ${lastNamePrinted.text}",
      printedRelation: learnerRelation.text,
      printedDate: dateEntered.text,
    );

    return residenceInfo;
  }

  String getRandomLetter() {
    Random random = Random();
    int randomAscii = random.nextInt(26) + 65; // ASCII code for capital letters (A-Z)
    String randomLetter = String.fromCharCode(randomAscii);
    return randomLetter;
  }

  int getRandomNumber() {
    Random random = Random();
    int randomNumber = random.nextInt(100); // Generate a random number between 0 and 99
    return randomNumber;
  }

  String generateRandomPassword() {
    Random random = Random();
    const String alphanumericChars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    String password = '';

    for (int i = 0; i < 6; i++) {
      int randomIndex = random.nextInt(alphanumericChars.length);
      password += alphanumericChars[randomIndex];
    }

    return password;
  }

  Future<void> submitApplicationForm(BuildContext context, {
    bool isJunior = false,
    bool isSenior = false,
  }) async {
    final ThemeData theme = Theme.of(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    showHUD(true);

    try {
      final ApplicationInfo applicationInfo = ApplicationInfo(
        schoolInfo: getSchoolInfo,
        personalInfo: getPersonalInfo,
        emergencyInfo: getEmergencyInfo,
        residenceInfo: getResidenceInfo,
      );

      final birth = DateFormat("MMyyyy").format(birthDay!).trim();

      final String controlNumber = "${getRandomLetter()}${getRandomNumber()}$birth";
      final String password = generateRandomPassword();

      await auth.createUserWithEmailAndPassword(
        email: "$controlNumber@gmail.com".toLowerCase(),
        password: password,
      ).then((value) {
        db.collection("students").doc(value.user!.uid).set({
          "id": value.user!.uid,
          "controlNumber": controlNumber.toLowerCase(),
          "password": password,
          ...applicationInfo.toJson(),
        });

        // send the account to the number
        sendSMS(
          controlNumber: controlNumber,
          password: password,
        );

        final CollectionReference subjectsCollection = db.collection("students")
            .doc(value.user!.uid)
            .collection("subjects");

        if (isJunior) {
          for (Subject subject in Commons.juniorSubject) {
            subjectsCollection.doc(subject.id.toString()).set(subject.toMap());
          }
        }

      });

      // clearForm();
      showHUD(false);

    } catch (e) {
      showHUD(false);
      Future.delayed(Duration.zero, () {
        showDialog(context: context, builder: (context) {
          return AlertDialog(
            content: Text("Please enter all valid requirements",
              style: theme.textTheme.bodyMedium!.copyWith(
                color: Colors.red,
              ),
            ),
          );
        });
      });

      throw "Error: $e";
    }

  }

  void clearForm() {
    schoolYear = null;
    gradeToEnroll = null;
    lastGradeCompleted = null;
    lastSchoolYearCompleted = null;
    residence = null;
    semester = null;
    track.clear();
    strand = null;


    schoolName.clear();
    schoolID.clear();
    schoolAddress.clear();
    schoolType = null;
    submitCopyPSA = null;
    birthCertNumber.clear();
    otherRequirements = null;

    hasLRN = null;
    learningReferenceNumber.clear();
    lastName.clear();
    firstName.clear();
    middleName.clear();
    extensionName.clear();
    placeOfBirth.clear();
    dateOfBirth.clear();
    age.clear();
    gender = null;
    isIndigenousPeople = null;
    motherTounge.clear();
    otherLanguages.clear();
    accessComm = null;
    phoneNumber.clear();
    emergencyFirstName.clear();
    emergencyMiddleName.clear();
    emergencyLastName.clear();
    relationship = null;
    emergencyAddress.clear();
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
    responsible = null;
    status = null;
    numberOfBrother.clear();
    numberOfSister.clear();
    birthOrder.clear();
    is4psBeneficiary = null;
    whenBeneficiary.clear();
    lastNamePrinted.clear();
    firstNamePrinted.clear();
    middleNamePrinted.clear();
    learnerRelation.clear();
    dateEntered.clear();
    notifyListeners();
  }


  Future<void> sendSMS({
    required String controlNumber,
    required String password,
}) async {
    final Uri uri = Uri.https("api.movider.co", "/v1/sms", {

    });
    
    await http.post(uri, body: {
      "api_key": ApiKey.smsApiKey,
      "api_secret": ApiKey.smsSecretApiKey,
      "to": phoneNumber.text,
      "text": "Your account is: Control number: $controlNumber and Password: $password",
    },
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "Accept": "application/json",
      }
    ).then((http.Response response) {
      if (response.statusCode == 200 && response.body.isNotEmpty) {
        debugPrint(response.body);
      } else {
        throw "Something went wrong. Please try again.";
      }
    }).timeout(const Duration(seconds: 30),
        onTimeout: () {
          throw "Time exceeded.";
        }).onError((error, stackTrace) {
       debugPrint("Error: $error");
       debugPrint("Stacktrace: $stackTrace");
    });
  }

}