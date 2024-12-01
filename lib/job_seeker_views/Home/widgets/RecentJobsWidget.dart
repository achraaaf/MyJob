import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/savedJobPostsController.dart';
import 'package:flutter_application_1/Repositories/authentication/authentication_Repository.dart';
import 'package:flutter_application_1/job_seeker_views/Home/Controller/JobPostController.dart';
import 'package:flutter_application_1/utils/Time/CalculateTime.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class RecentJobsWidget extends StatelessWidget {
  const RecentJobsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JobPostController());
    controller.fetchJobPosts();

    final authRepo = AuthenticationRepository.instance;

    final savedJobsController = Get.put(savedJobPostsController());

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Recent Posts",
            style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.w600,
                letterSpacing: -1),
          ),
          SizedBox(height: 20),
          Obx(
            () => ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: controller.jobPostsList.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  margin: EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 0.5,
                        blurRadius: 10,
                        offset: Offset(2, 1),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                controller.jobPostsList[index].EmployerImage),
                          ),
                          SizedBox(width: 10),
                          Text(
                            controller.jobPostsList[index].jobTitle,
                            style: GoogleFonts.poppins(
                              color: Color(0xff181F32),
                              fontSize: 19,
                              letterSpacing: -0.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Spacer(),
                          Obx(
                            () => IconButton(
                              onPressed: () {
                                savedJobsController.toggleSavedJobPost(
                                    authRepo.authUser!.uid,
                                    controller.jobPostsList[index]);
                              },
                              icon: savedJobsController.getIconForSavedJobs(
                                  controller.jobPostsList[index]),
                              iconSize: 28,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 7),
                      Divider(
                        color: Color.fromARGB(255, 214, 216, 221),
                        height: 2,
                        thickness: 0.8,
                        indent: 20,
                        endIndent: 20,
                      ),
                      SizedBox(height: 7),
                      Text(
                        controller.jobPostsList[index].employerName,
                        style: GoogleFonts.poppins(
                          color: Color(0xff181F32),
                          fontSize: 17,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        controller.jobPostsList[index].jobLocation,
                        style: GoogleFonts.inter(
                          color: Color(0xff181F32),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      Wrap(
                        spacing: 10,
                        runSpacing: 7,
                        children:
                            controller.jobPostsList[index].jobType.map((type) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.black.withOpacity(0.1),
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
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
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Text(
                            calculateTimeDifference(
                                controller.jobPostsList[index].PostedDate),
                            style: GoogleFonts.inter(
                              color: Colors.black.withOpacity(0.8),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text(
                              controller.jobPostsList[index].jobSalary,
                              style: GoogleFonts.inter(
                                color: Color(0xff181F32),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
