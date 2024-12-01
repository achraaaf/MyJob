import 'package:flutter/material.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/profile/skills/Components/SearchBar.dart';
import 'package:MyJob/job_seeker_views/pages/profile/skills/controller/SkillsController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

class addSkill extends StatefulWidget {
  const addSkill({super.key});

  @override
  State<addSkill> createState() => _addSkillState();
}

class _addSkillState extends State<addSkill> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SkillsController());
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          icon: Image(image: AssetImage("images/left-arrow.png")),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight,
                    child: BottomNavigationBarJobseeker(wantedPage: 4)));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Obx(
          () => Column(
            children: [
              Text(
                "Add Skills (${controller.selectedSkills.length})",
                style: GoogleFonts.dmSans(
                  color: Color(0xFF150B3D),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: TextField(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchBarView(),
                      ),
                    );
                  },
                  decoration: InputDecoration(
                      hintText: "Search skills",
                      hintStyle: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: Icon(Iconsax.search_normal),
                      filled: true,
                      fillColor: Colors.black.withOpacity(0.10000000149011612),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(13)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(13)),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
                ),
              ),
              SizedBox(height: 20),
              // selected skills section
              Container(
                width: double.infinity,
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: controller.selectedSkills.map((skill) {
                    return Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 73, 73, 73)
                            .withOpacity(0.10000000149011612),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            skill,
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(width: 8.0),
                          GestureDetector(
                            onTap: () async {
                              controller.removeSkill(skill);
                            },
                            child: Icon(
                              Icons.clear,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Spacer(),
              Center(
                child: Container(
                  padding: EdgeInsets.only(bottom: 8),
                  width: MediaQuery.of(context).size.width * 0.6,
                  height: 65,
                  child: ElevatedButton(
                    onPressed: () async {
                      final userRepo = UserRepository.Instance;
                      final JobSeekerData = JobSeekerController.instance;
                      // update skills from database
                      Map<String, dynamic> skillsDb = {
                        'skills': controller.selectedSkills
                      };
                      userRepo.updatesinglefield("Job_seekers", skillsDb);
                      // update the ui skills data
                      JobSeekerData.jobSeeker.value.skills =
                          controller.selectedSkills;

                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.leftToRight,
                              child:
                                  BottomNavigationBarJobseeker(wantedPage: 4)));
                    },
                    child: Text(
                      'Save',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ), backgroundColor: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 45)
            ],
          ),
        ),
      ),
    );
  }
}
