import 'package:flutter/material.dart';
import 'package:MyJob/Models/Job_seeker/education.dart';
import 'package:MyJob/job_seeker_views/pages/profile/education/Screens/AddEducationScreen.dart';
import 'package:MyJob/job_seeker_views/pages/profile/education/Screens/editEducationScreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class educationWidget extends StatelessWidget {
  final List<education> educations;

  const educationWidget(
      {Key? key, required this.educations, required this.scaffoldContext})
      : super(key: key);

  final BuildContext scaffoldContext;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
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
                        ImageIcon(
                          AssetImage("images/school.png"),
                          size: 30,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 13),
                        Text(
                          'Formations',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              scaffoldContext,
                              MaterialPageRoute(
                                builder: (contextx) => AddEducationScreen(),
                              ),
                            );
                          },
                          icon: Icon(Iconsax.add_circle4),
                          iconSize: 30,
                        )
                      ],
                    ),
                  ),
                  if (educations.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: educations.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final education = educations[index];
                        return Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, bottom: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    education.LevelofEducation,
                                    style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          scaffoldContext,
                                          MaterialPageRoute(
                                            builder: (contextx) =>
                                                editEducationScreen(
                                                    Education: education),
                                          ),
                                        );
                                      },
                                      icon: Icon(Iconsax.edit))
                                ],
                              ),
                              Text(
                                education.FieldOfStudy,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 31, 29, 37),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                education.InstitutionName,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF514A6B),
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    education.StartDate,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF514A6B),
                                    ),
                                  ),
                                  Text("  -  "),
                                  Text(
                                    education.EndDate,
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF514A6B),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              if (education.Description.trim().isNotEmpty)
                                Text(
                                  educations[index].Description,
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xFF514A6B),
                                  ),
                                ),
                              SizedBox(height: 8),
                              if (index < educations.length - 1)
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
            ),
          ),
        ],
      ),
    );
  }
}
