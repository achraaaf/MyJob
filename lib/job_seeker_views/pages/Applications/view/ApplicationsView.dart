import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/Applications/controller/JobApplicationsController.dart';
import 'package:MyJob/job_seeker_views/pages/Applications/widgets/JobApplicationDetails.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class ApplicationsView extends StatelessWidget {
  const ApplicationsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobApplicationsController());

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Candidatures",
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
        body: RefreshIndicator(
          onRefresh: () async {
            controller.fetchJobApplications();
          },
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: "Recherche",
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
                SizedBox(height: 20),
                Obx(
                  () {
                    if (controller.isLoading.value)
                      return SizedBox(
                        width: 400,
                        height: 400,
                        child: Lottie.asset("images/getting.json"),
                      );
                    if (controller.jobApplications.length == 0) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: 10),
                            Image(
                                image:
                                    AssetImage("images/noJobApplication.png")),
                            Padding(
                              padding: const EdgeInsets.only(top: 25),
                              child: Text(
                                "Aucune candidature trouvée",
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 22,
                                  letterSpacing: -0.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Vous n'avez encore postulé à aucun emploi. Recherchez des emplois pour postuler.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.jobPostApplications.length,
                        itemBuilder: (context, index) {
                          final jobApplication =
                              controller.jobApplications[index];
                          final jobPost = controller.jobPostApplications
                              .firstWhere((post) =>
                                  post.id == jobApplication.JobPostId);
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              margin: EdgeInsets.only(bottom: 7),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                JobApplicationDetails(
                                                  jobPost: jobPost,
                                                  jobApplication:
                                                      jobApplication,
                                                )),
                                      );
                                    },
                                    leading: CircleAvatar(
                                      radius: 26,
                                      backgroundColor: Colors.white,
                                      child: Padding(
                                        padding: EdgeInsets.all(5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image(
                                            image: NetworkImage(
                                                jobPost.EmployerImage),
                                          ),
                                        ),
                                      ),
                                    ),
                                    title: Text(
                                      jobPost.jobTitle,
                                      style: GoogleFonts.poppins(
                                        color: Color(0xff181F32),
                                        fontSize: 19,
                                        letterSpacing: -0.5,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        jobPost.employerName,
                                        style: GoogleFonts.poppins(
                                          color: Color(0xff616161),
                                          fontSize: 17,
                                          letterSpacing: -0.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    JobApplicationDetails(
                                                      jobPost: jobPost,
                                                      jobApplication:
                                                          jobApplication,
                                                    )),
                                          );
                                        },
                                        icon: Icon(Iconsax.arrow_right_34)),
                                    contentPadding: EdgeInsets.all(0),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 4),
                                    decoration: BoxDecoration(
                                        color: jobApplication.status ==
                                                "Approved"
                                            ? Color(0xfff2f9f2)
                                            : jobApplication.status == "Pending"
                                                ? Color(0xfffffbed)
                                                : Color(0xfffff2f2),
                                        borderRadius: BorderRadius.circular(7)),
                                    child: Text(
                                      "Application ${jobApplication.status}",
                                      style: GoogleFonts.poppins(
                                        color: jobApplication.status ==
                                                "Approved"
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
                                  SizedBox(height: 14),
                                  Divider(
                                    color: Color.fromARGB(255, 214, 216, 221),
                                    height: 2,
                                    thickness: 0.8,
                                    indent: 20,
                                    endIndent: 20,
                                  ),
                                  SizedBox(height: 7),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ));
  }
}
