import 'package:MyJob/Models/Job_seeker/Job_seeker.dart';
import 'package:MyJob/employer_screens/pages/Search/Widgets/EducationItem.dart';
import 'package:MyJob/employer_screens/pages/Search/Widgets/workExperienceItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class MoreDetailsWidget extends StatelessWidget {
  const MoreDetailsWidget({
    super.key,
    required this.jobSeeker,
  });

  final Job_seeker jobSeeker;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Color(0xff2B2B2B),
              borderRadius: BorderRadius.circular(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff404040),
                    ),
                    child: Icon(
                      Iconsax.edit_2,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "À propos de moi",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              if (!jobSeeker.AboutMe.trim().isEmpty)
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '•  ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      TextSpan(
                        text: jobSeeker.AboutMe.trim(),
                        style: GoogleFonts.dmSans(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: 10),
              // Contact section
              Row(
                children: [
                  Icon(
                    Iconsax.sms_tracking,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(jobSeeker.email, style: TextStyle(color: Colors.white)),
                ],
              ),
              SizedBox(height: 10),
              if (!jobSeeker.phone.trim().isEmpty)
                Row(
                  children: [
                    Icon(
                      Iconsax.call,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(jobSeeker.phone,
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
            ],
          ),
        ),
        SizedBox(height: 10),
        // Skills section
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xff2B2B2B),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff404040),
                    ),
                    child: Icon(
                      Iconsax.verify,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Compétences (${jobSeeker.skills.length})",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 5,
                runSpacing: 4,
                children: jobSeeker.skills
                    .map(
                      (skill) => Chip(
                        label: Text(
                          skill,
                          style: TextStyle(
                              fontFamily: 'Satoshi',
                              color: Colors.black,
                              fontWeight: FontWeight.w600),
                        ),
                        backgroundColor: Colors.white,
                        side: BorderSide.none,
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),

        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xff2B2B2B),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff404040),
                    ),
                    child: Icon(
                      Iconsax.briefcase,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Expérience professionnelle",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: jobSeeker.workExperiences.length,
                itemBuilder: (context, index) {
                  final experience = jobSeeker.workExperiences[index];
                  return Column(
                    children: [
                      WorkExperienceItem(experience: experience),
                      if (jobSeeker.workExperiences.length > 1)
                        Column(
                          children: [
                            SizedBox(height: 5),
                            Divider(
                              color: Color.fromARGB(255, 177, 178, 182),
                              height: 10,
                              thickness: 0.8,
                              indent: 10,
                              endIndent: 40,
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xff2B2B2B),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff404040),
                    ),
                    child: Icon(
                      Icons.language,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Langues (${jobSeeker.Languages.length})",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Wrap(
                spacing: 5,
                runSpacing: 4,
                children: jobSeeker.Languages.map(
                  (language) => Chip(
                    label: Text(
                      language,
                      style: TextStyle(
                          fontFamily: 'Satoshi',
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: Colors.white,
                    side: BorderSide.none,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                ).toList(),
              ),
            ],
          ),
        ),
        // Section Expérience de travail
        SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xff2B2B2B),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xff404040),
                    ),
                    child: Icon(
                      Iconsax.teacher,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Formations",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: jobSeeker.educations.length,
                itemBuilder: (context, index) {
                  final education = jobSeeker.educations[index];
                  return Column(
                    children: [
                      educationItem(Education: education),
                      if (jobSeeker.educations.length > 1)
                        Column(
                          children: [
                            SizedBox(height: 5),
                            Divider(
                              color: Color.fromARGB(255, 177, 178, 182),
                              height: 10,
                              thickness: 0.8,
                              indent: 10,
                              endIndent: 40,
                            ),
                          ],
                        ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
