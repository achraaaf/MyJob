import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Job_seeker/education.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/education/addEducation.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/education/editEducation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class educationWidget extends StatelessWidget {
  final List<education> educations;

  const educationWidget({Key? key, required this.educations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 73, 73, 73)
                    .withOpacity(0.10000000149011612),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage("images/school.png"),
                      size: 30,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 13),
                    Text(
                      'Education',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
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
            ),
          ),
          SizedBox(height: 4),
          ListView.builder(
            shrinkWrap: true,
            itemCount: educations.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 73, 73, 73)
                        .withOpacity(0.10000000149011612),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              educations[index].LevelofEducation,
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
                                      builder: (context) => editEducation(
                                        levelOfEducation:
                                            educations[index].LevelofEducation,
                                        InstitutionName:
                                            educations[index].InstitutionName,
                                        fieldOfStudy: educations[index].FieldOfStudy,
                                        start_date: educations[index].StartDate,
                                        end_date: educations[index].EndDate,
                                        description: educations[index].Description,
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(Iconsax.edit))
                          ],
                        ),
                        Text(
                          educations[index].FieldOfStudy,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 31, 29, 37),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          educations[index].InstitutionName,
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
                              educations[index].StartDate,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF514A6B),
                              ),
                            ),
                            Text("  -  "),
                            Text(
                              educations[index].EndDate,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF514A6B),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          educations[index].Description,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF514A6B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
