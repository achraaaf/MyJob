import 'package:cloud_firestore/cloud_firestore.dart';

class JobPostModel {
  String id;
  String jobTitle;
  String jobDescription;
  String jobLocation;
  List jobType;
  String jobSalary;
  Timestamp PostedDate;
  String employerId;
  String employerName;
  String EmployerImage;
  List RequiredSkills;
  String JobCategory;
  String Requirement;
  List Photos;
  bool isPopular;

  JobPostModel(
      {required this.id,
      required this.jobTitle,
      required this.jobDescription,
      required this.jobLocation,
      required this.jobType,
      required this.jobSalary,
      required this.PostedDate,
      required this.employerId,
      required this.employerName,
      required this.EmployerImage,
      required this.RequiredSkills,
      required this.Requirement,
      required this.JobCategory,
      required this.isPopular,
      required this.Photos});

  static JobPostModel EmptyJobPostModel() {
    return JobPostModel(
        id: "",
        jobTitle: "",
        jobDescription: "",
        jobLocation: "",
        jobType: [],
        jobSalary: "",
        PostedDate: Timestamp.now(),
        employerId: "",
        employerName: "",
        EmployerImage: "",
        RequiredSkills: [],
        Requirement: '',
        Photos: [],
        isPopular: false,
        JobCategory: '');
  }

  factory JobPostModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) return EmptyJobPostModel();

    final data = document.data()!;
    return JobPostModel(
      id: document.id,
      jobTitle: data['jobTitle'] ?? "",
      jobDescription: data['jobDescription'] ?? "",
      jobLocation: data['jobLocation'] ?? "",
      jobType: data['jobType'] ?? [],
      jobSalary: data['jobSalary'] ?? "",
      PostedDate: data['PostedDate'] ?? "",
      employerId: data['employerId'] ?? "",
      employerName: data['employerName'] ?? "",
      EmployerImage: data['EmployerImage'] ?? "",
      RequiredSkills: data['RequiredSkills'] ?? [],
      Requirement: data['Requirement'] ?? '',
      Photos: data['Photos'] ?? [],
      JobCategory: data['JobCategory'] ?? '',
      isPopular: data['isPopular'] ?? false,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobTitle': jobTitle,
      'jobDescription': jobDescription,
      'jobLocation': jobLocation,
      'jobType': jobType,
      'jobSalary': jobSalary,
      'PostedDate': PostedDate,
      'employerId': employerId,
      'employerName': employerName,
      'EmployerImage': EmployerImage,
      'RequiredSkills': RequiredSkills,
      'Requirement': Requirement,
      'Photos': Photos,
      'JobCategory': JobCategory,
      'isPopular': isPopular,
    };
  }

  static final jobTypes = [
    "Full Time",
    "Part Time",
    "Internship",
    "Temporary",
    "Contract",
  ];
}
