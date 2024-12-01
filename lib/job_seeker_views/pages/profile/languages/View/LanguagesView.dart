import 'package:flutter/material.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/profile/languages/Controller/LanguagesConroller.dart';
import 'package:MyJob/job_seeker_views/pages/profile/languages/View/addLanguage.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:page_transition/page_transition.dart';

class Languages extends StatelessWidget {
  Languages({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LanguagesConroller());

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          icon: Image(image: AssetImage("images/left-arrow.png")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Stack(
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Language (${controller.selectedLanguage.length})",
                      style: GoogleFonts.poppins(
                        color: Color(0xFF150B3D),
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddLanguage(),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              "Add ",
                              style: GoogleFonts.poppins(
                                color: Color(0xFF7551FF),
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(
                              Icons.add_circle,
                              color: Color(0xFF7551FF),
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 10),
                Obx(
                  () => Expanded(
                    child: ListView.builder(
                        itemCount: controller.selectedLanguage.length,
                        itemBuilder: (context, index) {
                          final language = controller.selectedLanguage[index];
                          final languageCode = controller.allLanguages.keys
                              .firstWhere((code) =>
                                  controller.allLanguages[code] == language);

                          return Container(
                            margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 0.3,
                                  blurRadius: 10,
                                  offset: Offset(1, 0),
                                )
                              ],
                            ),
                            child: ListTile(
                              leading: Image(
                                image: AssetImage(
                                  "assets/Flags/$languageCode.png",
                                ),
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.language),
                              ),
                              title: Text(
                                language,
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              trailing: IconButton(
                                  onPressed: () =>
                                      controller.removeLanguage(language),
                                  icon: Icon(Iconsax.trash)),
                              contentPadding:
                                  EdgeInsets.only(left: 20, right: 15),
                            ),
                          );
                        }),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(bottom: 8),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: 65,
                    child: ElevatedButton(
                      onPressed: () async {
                        final userRepo = UserRepository.Instance;
                        final JobSeekerData = JobSeekerController.instance;

                        final Map<String, dynamic> LanguagesData = {
                          "languages": controller.selectedLanguage,
                        };
                        userRepo.updatesinglefield("Job_seekers",LanguagesData);

                        JobSeekerData.jobSeeker.value.Languages =
                            controller.selectedLanguage;

                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.leftToRight,
                                child: BottomNavigationBarJobseeker(
                                    wantedPage: 4)));
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
                        ),
                        backgroundColor: Colors.black.withOpacity(0.95),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
