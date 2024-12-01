import 'package:cloud_firestore/cloud_firestore.dart';

class Employer {
  final String EmployerId;
   String city;
   String phone;
   String email;
   String CompanyLogo;
   String companyName;
   String Industry;
   String companySize;
   String description;

  Employer({
    required this.EmployerId,
    required this.city,
    required this.phone,
    required this.email,

    required this.CompanyLogo,
    required this.companyName,
    required this.description,
    required this.Industry,
    required this.companySize,
  });

  factory Employer.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;

    return Employer(
      EmployerId: doc.id,
      city: data['city'] ?? '',
      phone: data['phone'] ?? '',
      email: data['email'] ?? '',
      CompanyLogo: data['companyLogo'] ?? '',
      companyName: data['companyName'] ?? '',
      description: data['description'] ?? '',
      Industry: data['industry'] ?? '',
      companySize: data['companySize'] ?? '',
    );
  }

  static Employer emptyEmployer() {
    return Employer(
      EmployerId: '',
      city: '',
      phone: '',
      email: '',
      CompanyLogo: '',
      companyName: '',
      description: '',
      Industry: '',
      companySize: '',
    );
  }
}
