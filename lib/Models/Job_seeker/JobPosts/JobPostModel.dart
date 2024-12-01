import 'package:cloud_firestore/cloud_firestore.dart';

class JobPostModel {
  String jobTitle;
  String jobDescription;
  String jobLocation;
  List jobType;
  String jobSalary;
  String PostedDate;
  String employerId;
  String employerName;
  String EmployerImage;

  JobPostModel(
      {required this.jobTitle,
      required this.jobDescription,
      required this.jobLocation,
      required this.jobType,
      required this.jobSalary,
      required this.PostedDate,
      required this.employerId,
      required this.employerName,
      required this.EmployerImage});

  static JobPostModel EmptyJobPostModel() {
    return JobPostModel(
        jobTitle: "",
        jobDescription: "",
        jobLocation: "",
        jobType: [],
        jobSalary: "",
        PostedDate: "",
        employerId: "",
        employerName: "",
        EmployerImage: "");
  }

  factory JobPostModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return EmptyJobPostModel();

    final data = document.data()!;
    return JobPostModel(
      jobTitle: data['jobTitle'] ?? "",
      jobDescription: data['jobDescription'] ?? "",
      jobLocation: data['jobLocation'] ?? "",
      jobType: data['jobType'] ?? [],
      jobSalary: data['jobSalary'] ?? "",
      PostedDate: data['PostedDate'] ?? "",
      employerId: data['employerId'] ?? "",
      employerName: data['employerName'] ?? "",
      EmployerImage: data['EmployerImage'] ?? "",
    );
  }

  factory JobPostModel.fromJson(Map<String, dynamic> json) {
    return JobPostModel(
      jobTitle: json['jobTitle'] ?? "",
      jobDescription: json['jobDescription'] ?? "",
      jobLocation: json['jobLocation'] ?? "",
      jobType: json['jobType'] ?? [],
      jobSalary: json['jobSalary'] ?? "",
      PostedDate: json['PostedDate'] ?? "",
      employerId: json['employerId'] ?? "",
      employerName: json['employerName'] ?? "",
      EmployerImage: json['EmployerImage'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'jobLocation': jobLocation,
      'jobType': jobType,
      'jobSalary': jobSalary,
      'PostedDate': PostedDate,
      'employerId': employerId,
      'employerName': employerName,
      'EmployerImage': EmployerImage,
    };
  }


  
}
