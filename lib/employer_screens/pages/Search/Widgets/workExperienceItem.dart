
import 'package:MyJob/Models/Job_seeker/workExperience.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WorkExperienceItem extends StatelessWidget {
  final workExperience experience;

  const WorkExperienceItem({Key? key, required this.experience})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experience.title,
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 2),
            Text(
              experience.companyName,
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            SizedBox(height: 2),
            Text(
              ("${experience.startDate} - ${experience.endDate}"),
              style: TextStyle(
                fontSize: 12,
                color: const Color.fromARGB(255, 197, 197, 197),
              ),
            ),
            SizedBox(height: 2),
            if (experience.description.trim().isNotEmpty)
              Container(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  experience.description,
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
