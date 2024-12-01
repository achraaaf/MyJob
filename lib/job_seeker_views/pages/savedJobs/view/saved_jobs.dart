import 'package:flutter/material.dart';
import 'package:flutter_application_1/job_seeker_views/Home/Controller/savedJobPostsController.dart';
import 'package:flutter_application_1/Repositories/authentication/authentication_Repository.dart';
import 'package:flutter_application_1/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:flutter_application_1/job_seeker_views/pages/savedJobs/widgets/NoSavedJobsWidget.dart';
import 'package:flutter_application_1/job_seeker_views/pages/savedJobs/widgets/buildSavedPosts.dart';
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
          "Saved Jobs",
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (controller.savedJobPosts.length == 0) NoJobsSavedWidget(),
                if (controller.savedJobPosts.length != 0)
                  buildSavedPosts(controller: controller, authRepo: authRepo),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
