import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:MyJob/Models/Job_seeker/education.dart';
import 'package:MyJob/Models/Job_seeker/workExperience.dart';

class Job_seeker {
  late String id;
  late String AboutMe;
  late String name;
  late String email;
  late String city;
  late String phone;
  late String profilePicture;
  late List skills;
  late List Languages;
  late List<workExperience> workExperiences = [];
  late List<education> educations = [];

  Job_seeker({
    required this.id,
    required this.AboutMe,
    required this.name,
    required this.email,
    required this.city,
    required this.phone,
    required this.skills,
    required this.profilePicture,
    required this.Languages,
    required this.workExperiences,
    required this.educations,
  });

  toJson() {
    return {
      'id': id,
      'AboutMe': AboutMe,
      'name': name,
      'email': email,
      'city': city,
      'skills': skills,
      'languages': Languages,
      'aboutMe': AboutMe,
      'phone': phone,
    };
  }

  static Job_seeker fromJson(Map<String, dynamic>? jobSeekerData) {
    if (jobSeekerData == null) {
      return Job_seeker.emptyJobseeker();
    }
    final id = jobSeekerData['id'] as String? ?? '';
    final aboutMe = jobSeekerData['AboutMe'] as String? ?? '';

    final name = jobSeekerData['name'] as String? ?? '';
    final email = jobSeekerData['email'] as String? ?? '';
    final city = jobSeekerData['city'] as String? ?? '';
    final profilePic = jobSeekerData['picture'] as String? ?? '';

    final languages = jobSeekerData['languages'] ?? [];
    final skills = jobSeekerData['skills'] ?? [];
    final phone = jobSeekerData['phone'] as String? ?? '';
    return Job_seeker(
      id: id,
      AboutMe: aboutMe,
      name: name,
      email: email,
      phone: phone,
      city: city,
      Languages: languages,
      skills: skills,
      workExperiences: [],
      educations: [],
      profilePicture: profilePic,
    );
  }

  factory Job_seeker.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;


      return Job_seeker(
        id: data['id'],
        AboutMe: data['AboutMe'],
        name: data['name'],
        email: data['email'],
        city: data['city'],
        skills: data['skills'],
        Languages: data['languages'],
        phone: data['phone'],
        workExperiences: [],
        educations: [],
        profilePicture: data['picture'],
      );
    } else {
      return Job_seeker.emptyJobseeker();
    }
  }

  
  static Job_seeker emptyJobseeker() {
    return Job_seeker(
      id: '',
      AboutMe: '',
      name: '',
      email: '',
      city: '',
      phone: '',
      skills: [],
      workExperiences: [],
      educations: [],
      Languages: [],
      profilePicture: '',
    );
  }
}
