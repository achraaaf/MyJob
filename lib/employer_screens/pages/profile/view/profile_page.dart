import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:MyJob/employer_screens/pages/profile/widgets/MoreOptionsWidget.dart';
import 'package:MyJob/employer_screens/pages/profile/widgets/ProfileHeaderWidget.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late final EmployerController controller;
  @override
  void initState() {
    super.initState();
    controller = EmployerController.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // header
                ProfileHeader(),
                SizedBox(height: 10),
                OptionsSection()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
