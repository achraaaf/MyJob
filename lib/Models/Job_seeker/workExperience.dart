import 'package:cloud_firestore/cloud_firestore.dart';

class workExperience {
  late String companyName;
  late String title;
  late String description;
  late String startDate;
  late String endDate;

  workExperience({
    required this.companyName,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      'company': companyName,
      'title': title,
      'description': description,
      'Start_date': startDate,
      'End_date': endDate,
    };
  }

  factory workExperience.fromJson(Map<String, dynamic> json) {
    return workExperience(
        companyName: json['company'] ?? '',
        title: json['title'] ?? '',
        description: json['description'] ?? '',
        startDate: json['Start_date'] ?? '',
        endDate: json['End_date'] ?? '');
  }

  factory workExperience.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return workExperience(
      title: data['title'] ?? '',
      companyName: data['company'] ?? '',
      startDate: data['Start_date'] ?? '',
      endDate: data['End_date'] ?? '',
      description: data['description'] ?? '',
    );
  }
}
