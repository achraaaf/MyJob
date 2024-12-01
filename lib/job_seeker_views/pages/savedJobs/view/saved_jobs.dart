import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/savedJobPostsController.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/savedJobs/widgets/NoSavedJobsWidget.dart';
import 'package:MyJob/job_seeker_views/pages/savedJobs/widgets/buildSavedPosts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedJobs extends StatelessWidget {
  const SavedJobs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = savedJobPostsController.instance;
    final authRepo = AuthenticationRepository.instance;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Emplois enregistrés",
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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Obx(() {
                if (controller.savedJobPosts.length == 0) {
                  return NoJobsSavedWidget();
                }
                ;
                if (controller.savedJobPosts.length != 0) {
                  return buildSavedPosts(
                      controller: controller, authRepo: authRepo);
                }
                return SizedBox.shrink();
              })
            ],
          ),
        ),
      ),
    );
  }
}
