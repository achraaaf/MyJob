import 'package:flutter/material.dart';
import 'package:flutter_application_1/Models/Job_seeker/workExperience.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/Work_Experience/Screens/EditworkExperienceScreen.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/Work_Experience/Screens/editWorkExperience.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class workExperiencesWidget extends StatelessWidget {
  final List<workExperience> workExperiences;

  const workExperiencesWidget(
      {Key? key,
      required this.workExperiences,
      required this.onAddPressed,
      required this.onEditPressed
      })
      : super(key: key);

  final VoidCallback onAddPressed;
  final Function(int) onEditPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 8, right: 8),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 73, 73, 73).withOpacity(0.1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Icon(
                      Iconsax.briefcase,
                      color: Color(0xFFFF6868),
                    ),
                    SizedBox(width: 13),
                    Text(
                      'Works Experiences',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    IconButton(
                      onPressed: onAddPressed,
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
            itemCount: workExperiences.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 73, 73, 73).withOpacity(0.1),
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
                              workExperiences[index].companyName,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                                onPressed: () => onEditPressed(index),
                                icon: Icon(Iconsax.edit))
                          ],
                        ),
                        Text(
                          workExperiences[index].title,
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
                              workExperiences[index].startDate,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF514A6B),
                              ),
                            ),
                            Text("  -  "),
                            Text(
                              workExperiences[index].endDate,
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
                          workExperiences[index].description,
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
