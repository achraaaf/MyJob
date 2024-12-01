import 'package:MyJob/Authentication/SignIn_Up.dart';
import 'package:MyJob/Repositories/Chat/chatRepository.dart';
import 'package:MyJob/Repositories/JobPost/JobPostsRepository.dart';
import 'package:MyJob/Repositories/JobPost/SavedJobPostRepository.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/JobPostController.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/savedJobPostsController.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/controller/messagesController.dart';
import 'package:MyJob/job_seeker_views/pages/profile/EditProfile/controller/editProfileController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/profile/EditProfile/view/editProfileView.dart';
import 'package:MyJob/job_seeker_views/pages/profile/AboutMe/editAboutMe.dart';
import 'package:MyJob/job_seeker_views/pages/profile/widgets/EducationsWidget.dart';
import 'package:MyJob/job_seeker_views/pages/profile/widgets/SkillsWidget.dart';
import 'package:MyJob/job_seeker_views/pages/profile/widgets/getAboutmeWidget.dart';
import 'package:MyJob/job_seeker_views/pages/profile/widgets/languagesWidget.dart';
import 'package:MyJob/job_seeker_views/pages/profile/widgets/workExperiencesWidget.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late var controller;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _reloadData() async {
    controller = JobSeekerController.instance;
    controller.fetchJobSeekersRecord();
  }

  @override
  Widget build(BuildContext context) {
    controller = JobSeekerController.instance;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Mon Profile",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomNavigationBarJobseeker(),
                ),
              );
            },
            icon: Image(
              image: AssetImage("images/left-arrow.png"),
            ),
          ),
          actions: [
            IconButton(
              padding: EdgeInsets.only(right: 15),
              onPressed: () {
                Logout(context);
              },
              icon: Icon(Iconsax.logout),
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            color: Color(0xFFF9F9F9),
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: RefreshIndicator(
                onRefresh: _reloadData,
                child: SingleChildScrollView(
                  child: Obx(
                    () {
                      final jobSeeker = controller.jobSeeker.value;

                      final networkImage = jobSeeker.profilePicture;
                      final ProfileImage = networkImage.isNotEmpty
                          ? NetworkImage(networkImage)
                          : AssetImage("images/fitgirl2.jpg");

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ======================= Header Section ==========================
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.only(
                                right: 10, left: 20, bottom: 50),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      "images/Background.png",
                                    ),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(30)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 36,
                                      backgroundImage:
                                          ProfileImage as ImageProvider,
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      jobSeeker.name,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Spacer(),
                                    Column(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        editProfileScreen()));
                                          },
                                          icon: Icon(Iconsax.user_edit),
                                          color: Colors.white,
                                          iconSize: 32,
                                        ),
                                        Text(
                                          "Modifier",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  jobSeeker.email,
                                  style: GoogleFonts.poppins(
                                    color: Color.fromARGB(255, 231, 229, 229),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 7),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      jobSeeker.city,
                                      style: GoogleFonts.poppins(
                                        color:
                                            Color.fromARGB(255, 231, 229, 229),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ImageIcon(
                                        AssetImage("images/share.png"),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),

                          // Content Section
                          Container(
                            child: Column(
                              children: [
                                AboutMeWidget(
                                    aboutMe: jobSeeker.AboutMe,
                                    onEditPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                editAboutMe()))),
                                // ============ works Experiences ================
                                workExperiencesWidget(
                                  workExperiences: jobSeeker.workExperiences,
                                  contextp: context,
                                ),
                                // ============ Skills ================
                                SkillsWidget(skills: jobSeeker.skills),
                                // =============== educations ==================
                                educationWidget(
                                  educations: jobSeeker.educations,
                                  scaffoldContext: context,
                                ),
                                // =============== Languages ==================

                                languagesWidget(languages: jobSeeker.Languages),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Future<dynamic> Logout(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      barrierColor: Color(0xFF7E8488).withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // ============= for the little bar to slide ===========
              Row(
                children: [
                  Spacer(),
                  Container(
                    height: 4,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.grey),
                  ),
                  Spacer()
                ],
              ),

              SizedBox(height: 10),
              Text(
                'Log Out ?',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Are you sure you want to Logout?',
                style: GoogleFonts.poppins(
                  color: Color(0xFF514A6B),
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();

                    Get.delete<JobSeekerController>(force: true);
                    Get.delete<UserRepository>();
                    Get.delete<ChatRepository>();
                    Get.delete<JobPostController>();
                    Get.delete<MessagesController>();
                    Get.delete<savedJobPostsController>();
                    Get.delete<editProfileController>();
                    Get.delete<MessagesController>();
                    Get.delete<JobPostsRepository>();
                    Get.delete<savedJobPostRepository>();

                    Get.offAll(() => signin_up());
                  },
                  child: Text(
                    'Yes Logout !',
                    style: GoogleFonts.dmSans(
                        color: Colors.white,
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w500),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel !',
                    style: GoogleFonts.dmSans(
                        color: Colors.black,
                        fontSize: 20,
                        letterSpacing: 1,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xFFD7CDFF),
                  ),
                ),
              ),
              SizedBox(height: 20)
            ],
          ),
        );
      },
    );
  }
}
