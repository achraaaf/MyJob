import 'package:flutter/material.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Models/jobApplication/JobApplication.dart';
import 'package:MyJob/Repositories/Chat/chatRepository.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/Messages/controller/messagesController.dart';
import 'package:MyJob/utils/Time/CalculateTime.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class JobApplicationDetails extends StatelessWidget {
  JobApplicationDetails(
      {super.key, required this.jobPost, required this.jobApplication});
  final JobPostModel jobPost;
  final JobApplication jobApplication;

  final currentUser = AuthenticationRepository.instance.authUser!.uid;
  final controller = Get.put(MessagesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Applicaiton Stages",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            image: AssetImage("images/left-arrow.png"),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Center(
          child: Column(
            children: [
              // ======= Post image =======
              Container(
                width: MediaQuery.of(context).size.width / 3.5,
                height: MediaQuery.of(context).size.height / 7,
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  color: Color(0xffF5F1FB),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 228, 227, 227),
                      spreadRadius: 0.5,
                      blurRadius: 8,
                      offset: Offset(2, 1),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image(
                    image: NetworkImage(jobPost.EmployerImage),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(
                height: 17,
              ),
              // ======= Post title =======
              Text(
                jobPost.jobTitle,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  letterSpacing: -0.5,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 7),
              Text(
                jobPost.employerName,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  letterSpacing: -0.5,
                  color: Color(0xff246bfd),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 10),

              // ======= Post Location =======
              Text(
                jobPost.jobLocation,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  letterSpacing: -0.5,
                  color: Color.fromARGB(255, 63, 63, 63),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(
                height: 7,
              ),
              // ======= jobSalary =======
              Text(
                jobPost.jobSalary,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  letterSpacing: -0.5,
                  color: Color(0xff246bfd),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Wrap(
                spacing: 10,
                runSpacing: 7,
                children: jobPost.jobType.map((type) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.1),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                    child: Text(
                      type,
                      style: GoogleFonts.inter(
                        color: Color(0xff181F32),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(
                height: 10,
              ),
              // ========= post date =========
              Text(
                "Applied ${calculateTimeDifference(jobApplication.applicationDate)}",
                style: GoogleFonts.inter(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 15),
              Divider(
                color: Colors.grey.withOpacity(0.3),
                thickness: 2,
                indent: 30,
                endIndent: 30,
              ),
              SizedBox(height: 15),
              Text(
                "Your Application Status",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  letterSpacing: -0.5,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 15),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: jobApplication.status == "Approved"
                        ? Color(0xfff2f9f2)
                        : jobApplication.status == "Pending"
                            ? Color(0xfffffbed)
                            : Color(0xfffff2f2),
                    borderRadius: BorderRadius.circular(7)),
                child: Text(
                  textAlign: TextAlign.center,
                  "Application ${jobApplication.status}",
                  style: GoogleFonts.poppins(
                    color: jobApplication.status == "Approved"
                        ? Color(0xff07bd74)
                        : jobApplication.status == "Pending"
                            ? Color(0xfffbcd17)
                            : Color(0xfff75555),
                    fontSize: 16,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Spacer(),
              if (jobApplication.status == "Approved")
                Center(
                  child: Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: ElevatedButton(
                      onPressed: () async {
                        final chatRepo = Get.put(ChatRepository());
                        await chatRepo.createChatConversation(
                            jobSeekerId: currentUser,
                            employerId: jobPost.employerId);
                        controller.getConversations();
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                BottomNavigationBarJobseeker(wantedPage: 3),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.black,
                      ),
                      child: Text(
                        'Send Message',
                        style: GoogleFonts.dmSans(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            letterSpacing: 1),
                      ),
                    ),
                  ),
                ),
              SizedBox(height: 20)
            ],
          ),
        ),
      ),
    );
  }
}
