import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/pages/profile/skills/view/addSkill.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SkillsWidget extends StatelessWidget {
  final List skills;

  const SkillsWidget({Key? key, required this.skills}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 18),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Row(
                      children: [
                        ImageIcon(
                          AssetImage("images/IconSkill.png"),
                          color: Colors.green,
                        ),
                        SizedBox(width: 13),
                        Text(
                          'Compétences',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => addSkill(),
                              ),
                            );
                          },
                          icon: Icon(Iconsax.edit),
                          iconSize: 25,
                        ),
                      ],
                    ),
                  ),
                  if (skills.isNotEmpty)
                    Column(
                      children: [
                        Divider(
                          color: Color(0xFFDEE1E7),
                          height: 3,
                          thickness: 0.8,
                          indent: 20,
                          endIndent: 20,
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Wrap(
                              spacing: 10,
                              children: [
                                for (String item in skills)
                                  Container(
                                    margin: EdgeInsets.only(bottom: 10),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 30),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: Color(0xFF171E30),
                                    ),
                                    child: Text(
                                      item,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
