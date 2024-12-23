import 'package:cloud_firestore/cloud_firestore.dart';

class JobApplication {
  late String id;
  late String JobSeekerId;
  late String JobPostId;
  late String status;
  late String email;
  late String resume;
  late String applicationDate;
  String MotivationLetter;
  JobApplication({
    required this.id,
    required this.JobSeekerId,
    required this.JobPostId,
    required this.status,
    required this.email,
    required this.resume,
    required this.applicationDate,
    required this.MotivationLetter,
  });

  factory JobApplication.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> Doc) {
    final data = Doc.data()!;

    return JobApplication(
        id: Doc.id,
        JobSeekerId: data['JobSeekerId'] ?? '',
        JobPostId: data['jobPostId'] ?? '',
        status: data['status'] ?? '',
        email: data['email'] ?? '',
        resume: data['cv/resume'] ?? '',
        applicationDate: data['applicationDate'] ?? '',
        MotivationLetter: data['motivationLetter'] ?? '');
  }

  static JobApplication EmptyJobApplication() {
    return JobApplication(
        id: '',
        JobSeekerId: '',
        JobPostId: '',
        status: '',
        email: '',
        resume: '',
        MotivationLetter: '',
        applicationDate: '');
  }
}
