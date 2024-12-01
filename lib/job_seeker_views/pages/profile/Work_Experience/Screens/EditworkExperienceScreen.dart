import 'package:flutter/material.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/Work_Experience/Widgets/EditworkExperienceForm.dart';
import 'package:google_fonts/google_fonts.dart';

class editWorkExperienceScreen extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String start_date;
  final String end_date;
  final String description;

  const editWorkExperienceScreen(
      {super.key,
      required this.jobTitle,
      required this.company,
      required this.start_date,
      required this.end_date,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          icon: Image(image: AssetImage("images/left-arrow.png")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Change work experience',
                style: GoogleFonts.dmSans(
                  color: Color(0xFF150B3D),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 25),
              EditworkExperienceForm(
                  jobTitle: jobTitle,
                  company: company,
                  start_date: start_date,
                  end_date: end_date,
                  description: description)
            ],
          ),
        ),
      ),
    );
  }
}
