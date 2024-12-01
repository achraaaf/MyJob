import 'package:cloud_firestore/cloud_firestore.dart';

class JobApplication {
  late String id;
  late String JobSeekerId;
  late String JobPostId;
  late String status;
  late String applicationDate;

  JobApplication({
    required this.id,
    required this.JobSeekerId,
    required this.JobPostId,
    required this.status,
    required this.applicationDate,
  });

  factory JobApplication.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> Doc) {
    final data = Doc.data()!;

    return JobApplication(
        id: Doc.id,
        JobSeekerId: data['JobSeekerId'] ?? '',
        JobPostId: data['jobPostId'] ?? '',
        status: data['status'] ?? '',
        applicationDate: data['applicationDate'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'JobSeekerId': JobSeekerId,
      'JobPostId': JobPostId,
      'applicationDate': applicationDate,
      'status': status,
    };
  }

  static JobApplication EmptyJobApplication() {
    return JobApplication(
        id: '',
        JobSeekerId: '',
        JobPostId: '',
        status: '',
        applicationDate: '');
  }
}
