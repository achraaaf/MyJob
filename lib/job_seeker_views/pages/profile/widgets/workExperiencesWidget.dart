import 'package:flutter/material.dart';
import 'package:MyJob/Models/Job_seeker/workExperience.dart';
import 'package:MyJob/job_seeker_views/pages/profile/Work_Experience/Screens/AddWorkExperienceScreen.dart';
import 'package:MyJob/job_seeker_views/pages/profile/Work_Experience/Screens/editWorkExperience.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class workExperiencesWidget extends StatelessWidget {
  final List<workExperience> workExperiences;
  final BuildContext contextp;

  workExperiencesWidget(
      {Key? key, required this.workExperiences, required this.contextp})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> KeyForAddWorkExp = GlobalKey<FormState>();

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1.5,
                    blurRadius: 10,
                    offset: Offset(2, 1),
                  )
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Row(
                      children: [
                        Icon(
                          Iconsax.briefcase,
                          color: Color(0xFFFF6868),
                        ),
                        SizedBox(width: 13),
                        Text(
                          'Expériences',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                                contextp,
                                MaterialPageRoute(
                                    builder: (contextp) =>
                                        addWorkExperienceScreen(
                                            addWorkExperienceFormKey:
                                                KeyForAddWorkExp)));
                          },
                          icon: Icon(Iconsax.add_circle4),
                          iconSize: 30,
                        )
                      ],
                    ),
                  ),
                  if (workExperiences.isNotEmpty)
                    Column(
                      children: [
                        Divider(
                          color: Color(0xFFDEE1E7),
                          height: 2,
                          thickness: 0.8,
                          indent: 20,
                          endIndent: 20,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: workExperiences.length,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            final workExperience = workExperiences[index];
                            return Padding(
                              padding: EdgeInsets.only(
                                  right: 15, left: 15, bottom: 13),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        workExperience.companyName,
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                              contextp,
                                              MaterialPageRoute(
                                                builder: (contextp) =>
                                                    editWorkExperience(
                                                        WorkExperience:
                                                            workExperience),
                                              ),
                                            );
                                          },
                                          icon: Icon(Iconsax.edit))
                                    ],
                                  ),
                                  Text(
                                    workExperience.title,
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF514A6B),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Text(
                                        workExperience.startDate,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF514A6B),
                                        ),
                                      ),
                                      Text("  -  "),
                                      Text(
                                        workExperience.endDate,
                                        style: GoogleFonts.poppins(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Color(0xFF514A6B),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  if (workExperience.description
                                      .trim()
                                      .isNotEmpty)
                                    Text(
                                      workExperience.description.trim(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF514A6B),
                                      ),
                                    ),
                                  SizedBox(height: 8),
                                  if (index < workExperiences.length - 1)
                                    Divider(
                                      color: Color(0xFFDEE1E7),
                                      height: 1,
                                      thickness: 0.8,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
