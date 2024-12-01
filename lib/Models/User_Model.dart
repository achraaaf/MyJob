import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  final String name;
  final String email;
  final String role;

  UserModel(
      {this.id, required this.name, required this.email, required this.role});

  toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
    };
  }

  factory UserModel.fromSnapshot( DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return UserModel(
      id: data['id'],
      name: data['name'],
      email: data['email'],
      role: data['role'],
    );
  }
}
