
import 'package:flutter/material.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/skills/addSkill.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/skills/editSkills.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

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
              height: MediaQuery.of(context).size.height * 0.08,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 73, 73, 73)
                    .withOpacity(0.10000000149011612),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    ImageIcon(
                      AssetImage("images/IconSkill.png"),
                      color: Colors.green,
                    ),
                    SizedBox(width: 13),
                    Text(
                      'Skills',
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
                      icon: Icon(Iconsax.add_circle4),
                      iconSize: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 4),
          if (skills.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 73, 73, 73)
                          .withOpacity(0.10000000149011612),
                      borderRadius: BorderRadius.circular(15),
                    ),
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
                                color: Color(0xFF1E1F1E),
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
                  Positioned(
                    top: 8,
                    right: 8,
                    child: IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.rightToLeft,
                            child: editSkills(),
                          ),
                        );
                      },
                      icon: Icon(Iconsax.edit),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
