import 'package:flutter/cupertino.dart';
import 'package:school_management/models/student/new_subject.dart';

class Commons extends ChangeNotifier {

  static String? forcedTextValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? forcedDropdownValidator(value) {
    if (value == null) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static List<Subject> juniorSubject = [
    Subject(name: "Filipino", enrolled: false, grades: [], id: 0, units: 3),
    Subject(name: "English", enrolled: false, grades: [], id: 1, units: 4),
    Subject(name: "Mathematics", enrolled: false, grades: [], id: 2, units: 1),
    Subject(name: "Science", enrolled: false, grades: [], id: 3, units: 3),
    Subject(name: "Araling Panlipunan", enrolled: false, grades: [], id: 4, units: 3),
    Subject(name: "Edukasyon sa Pagpapakatao", enrolled: false, grades: [], id: 5, units: 3),
    Subject(name: "Technology and Livelihood Education", enrolled: false, grades: [], id: 6, units: 3),
    Subject(name: "Music", enrolled: false, grades: [], id: 7, units: 3),
    Subject(name: "Arts", enrolled: false, grades: [], id: 8, units: 3),
    Subject(name: "Physical Education", enrolled: false, grades: [], id: 9, units: 3),
    Subject(name: "Health", enrolled: false, grades: [], id: 10, units: 3),
  ];

  static List<Subject> stemFirstSubjectList = [
    Subject(name: "Practical Research 1", enrolled: false, grades: [], units: 1, id: 0),
    Subject(name: "Practical Research 2", enrolled: false, grades: [], units: 1, id: 1),
    Subject(name: "General Biology", enrolled: false, grades: [], units: 1, id: 2),
    Subject(name: "General Chemistry 1", enrolled: false, grades: [], units: 1, id: 3),
    Subject(name: "General Physics 1", enrolled: false, grades: [], units: 1, id: 4),
    Subject(name: "Pre Calculus", enrolled: false, grades: [], units: 1, id: 5),
    Subject(name: "Media Information Literacy", enrolled: false, grades: [], units: 1, id: 6),
    Subject(name: "Intro to Philo of Human Resources", enrolled: false, grades: [], units: 1, id: 7),
    Subject(name: "Understanding Culture, Society & Politics", enrolled: false, grades: [], units: 1, id: 8),
    Subject(name: "Physical Health and Education", enrolled: false, grades: [], units: 1, id: 9),
    Subject(name: "Reading and Writing", enrolled: false, grades: [], units: 1, id: 10),
  ];

  static List<Subject> stemSecondSubjectList = [
    Subject(name: "Entrepeneurship", enrolled: false, grades: [], units: 1, id: 0),
    Subject(name: "Empowerment Technologies", enrolled: false, grades: [], units: 1, id: 1),
    Subject(name: "Inquiries, Investigation and Immersion", enrolled: false, grades: [], units: 1, id: 2),
    Subject(name: "General Biology 2", enrolled: false, grades: [], units: 1, id: 3),
    Subject(name: "General Chemistry 2", enrolled: false, grades: [], units: 1, id: 4),
    Subject(name: "General Physics 2", enrolled: false, grades: [], units: 1, id: 5),
    Subject(name: "Basic Calculus", enrolled: false, grades: [], units: 1, id: 6),
    Subject(name: "Work Immersion", enrolled: false, grades: [], units: 1, id: 7),
    Subject(name: "Physical Education", enrolled: false, grades: [], units: 1, id: 8),
  ];

  static List<Subject> gasFirstSubjectList = [
    Subject(name: "Practical Research 1", enrolled: false, grades: [], units: 1, id: 0),
    Subject(name: "Practical Research 2", enrolled: false, grades: [], units: 1, id: 1),
    Subject(name: "Intro. to World Religions & Belief Sys", enrolled: false, grades: [], units: 1, id: 2),
    Subject(name: "Tech/Voc Elective 1: Bread and Pastry", enrolled: false, grades: [], units: 1, id: 3),
    Subject(name: "Trends, Networks, & Critical Thinking in the 21st Century", enrolled: false, grades: [], units: 1, id: 4),
    Subject(name: "Media Information Literacy", enrolled: false, grades: [], units: 1, id: 6),
    Subject(name: "Intro to Philo of Human Resources", enrolled: false, grades: [], units: 1, id: 7),
    Subject(name: "Understanding Culture, Society & Politics", enrolled: false, grades: [], units: 1, id: 8),
    Subject(name: "Physical Health and Education", enrolled: false, grades: [], units: 1, id: 9),
    Subject(name: "Reading and Writing", enrolled: false, grades: [], units: 1, id: 10),
  ];

  static List<Subject> gasSecondSubjectList = [
    Subject(name: "Entrepeneurship", enrolled: false, grades: [], units: 1, id: 0),
    Subject(name: "Empowerment Technologies", enrolled: false, grades: [], units: 1, id: 1),
    Subject(name: "Inquiries, Investigation and Immersion", enrolled: false, grades: [], units: 1, id: 2),
    Subject(name: "Tech/Voc Elective 1: Electronics", enrolled: false, grades: [], units: 1, id: 3),
    Subject(name: "Community Engagement, Solidarity & Citizenship", enrolled: false, grades: [], units: 1, id: 4),
    Subject(name: "Applied Economics", enrolled: false, grades: [], units: 1, id: 5),
    Subject(name: "Organization and Management", enrolled: false, grades: [], units: 1, id: 6),
    Subject(name: "Work Immersion", enrolled: false, grades: [], units: 1, id: 7),
    Subject(name: "Physical Education", enrolled: false, grades: [], units: 1, id: 8),
  ];

  static List<Subject> hummsFirstSubjectList = [
    Subject(name: "Practical Research 1", enrolled: false, grades: [], units: 1, id: 0),
    Subject(name: "Practical Research 2", enrolled: false, grades: [], units: 1, id: 1),
    Subject(name: "Intro. to World Religions & Belief Sys", enrolled: false, grades: [], units: 1, id: 2),
    Subject(name: "Creative Writing", enrolled: false, grades: [], units: 1, id: 3),
    Subject(name: "Trends, Networks, & Critical Thinking in the 21st Century", enrolled: false, grades: [], units: 1, id: 4),
    Subject(name: "Philippine Politics & Governance", enrolled: false, grades: [], units: 1, id: 6),
    Subject(name: "Media Information Literacy", enrolled: false, grades: [], units: 1, id: 7),
    Subject(name: "Intro to Philo of Human Resources", enrolled: false, grades: [], units: 1, id: 8),
    Subject(name: "Understanding Culture, Society & Politics", enrolled: false, grades: [], units: 1, id: 9),
    Subject(name: "Physical Health and Education", enrolled: false, grades: [], units: 1, id: 10),
    Subject(name: "Reading and Writing", enrolled: false, grades: [], units: 1, id: 11),
  ];

  static List<Subject> hummsSecondSubjectList = [
    Subject(name: "Entrepeneurship", enrolled: false, grades: [], units: 1, id: 0),
    Subject(name: "Empowerment Technologies", enrolled: false, grades: [], units: 1, id: 1),
    Subject(name: "Inquiries, Investigation and Immersion", enrolled: false, grades: [], units: 1, id: 2),
    Subject(name: "Creative Nonfiction", enrolled: false, grades: [], units: 1, id: 3),
    Subject(name: "Community Engagement, Solidarity & Citizenship", enrolled: false, grades: [], units: 1, id: 4),
    Subject(name: "Discipline & Ideas in the Social Sci.", enrolled: false, grades: [], units: 1, id: 5),
    Subject(name: "Disciplines & Ideas in the Applied Soc. Sci.", enrolled: false, grades: [], units: 1, id: 6),
    Subject(name: "Work Immersion", enrolled: false, grades: [], units: 1, id: 7),
    Subject(name: "Physical Education", enrolled: false, grades: [], units: 1, id: 8),
  ];
}