import 'package:flutter/material.dart';
import 'package:flutter_application_1/job_seeker_views/Home/Controller/savedJobPostsController.dart';
import 'package:flutter_application_1/Repositories/authentication/authentication_Repository.dart';
import 'package:flutter_application_1/utils/Time/CalculateTime.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class buildSavedPosts extends StatelessWidget {
  const buildSavedPosts({
    super.key,
    required this.controller,
    required this.authRepo,
  });

  final savedJobPostsController controller;
  final AuthenticationRepository authRepo;

  @override
  Widget build(BuildContext context) {
    print(
        "================${controller.savedJobPosts.length} ==================");
    return Obx(
      () => ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: controller.savedJobPosts.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              margin: EdgeInsets.only(bottom: 20),
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
                            controller.savedJobPosts[index].EmployerImage),
                      ),
                      SizedBox(width: 10),
                      Text(
                        controller.savedJobPosts[index].jobTitle,
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
                            controller.toggleSavedJobPost(
                                authRepo.authUser!.uid,
                                controller.savedJobPosts[index],
                                context);
                          },
                          icon: controller.getIconForSavedJobs(
                              controller.savedJobPosts[index]),
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
                    controller.savedJobPosts[index].employerName,
                    style: GoogleFonts.poppins(
                      color: Color(0xff181F32),
                      fontSize: 17,
                      letterSpacing: -0.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    controller.savedJobPosts[index].jobLocation,
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
                        controller.savedJobPosts[index].jobType.map((type) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.black.withOpacity(0.1),
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 4),
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
                            controller.savedJobPosts[index].PostedDate),
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
                          controller.savedJobPosts[index].jobSalary,
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
            ),
          );
        },
      ),
    );
  }
}
