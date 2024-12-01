import 'package:MyJob/Models/Job_seeker/education.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class educationItem extends StatelessWidget {
  final education Education;
  const educationItem({Key? key, required this.Education}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Education.LevelofEducation,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 2),
            Text(
              Education.FieldOfStudy,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            SizedBox(height: 2),
            Text(
              Education.InstitutionName,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            SizedBox(height: 2),
            Text(
              ("${Education.StartDate} - ${Education.EndDate}"),
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(255, 197, 197, 197),
              ),
            ),
            SizedBox(height: 2),
            if (Education.Description.trim().isNotEmpty)
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  Education.Description,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}
