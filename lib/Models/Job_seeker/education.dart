import 'package:cloud_firestore/cloud_firestore.dart';

class education {
  late String FieldOfStudy;
  late String InstitutionName;
  late String LevelofEducation;
  late String StartDate;
  late String EndDate;
  late String Description;

  education({
    required this.FieldOfStudy,
    required this.InstitutionName,
    required this.LevelofEducation,
    required this.StartDate,
    required this.EndDate,
    required this.Description,
  });

  toJson() {
    return {
      'FieldOfStudy': FieldOfStudy,
      'InstitutionName': InstitutionName,
      'LevelofEducation': LevelofEducation,
      'Start_date': StartDate,
      'End_date': EndDate,
      'description': Description,
    };
  }

  factory education.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return education(
      InstitutionName: data['InstitutionName']?? '',
      LevelofEducation: data['LevelofEducation']?? '',
      FieldOfStudy: data['FieldOfStudy']?? '',
      StartDate: data['Start_date']?? '',
      EndDate: data['End_date']?? '',
      Description: data['description']?? '',
    );
  }
}
