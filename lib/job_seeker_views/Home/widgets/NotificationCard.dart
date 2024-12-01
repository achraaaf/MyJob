import 'package:MyJob/Models/Employer/Employer.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Models/jobApplication/JobApplication.dart';
import 'package:MyJob/Repositories/user/User_Repository.dart';
import 'package:MyJob/job_seeker_views/Home/Controller/NotificationController.dart';
import 'package:MyJob/job_seeker_views/pages/Applications/widgets/JobApplicationDetails.dart';
import 'package:MyJob/utils/Time/CalculateTime.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class NotificationCardJ extends StatefulWidget {
  final String title;
  final String content;
  final Timestamp timestamp;
  final String employerId;
  final String jobApplicationId;
  const NotificationCardJ(
      {super.key,
      required this.title,
      required this.content,
      required this.timestamp,
      required this.employerId,
      required this.jobApplicationId});

  @override
  State<NotificationCardJ> createState() => _NotificationCardJState();
}

class _NotificationCardJState extends State<NotificationCardJ> {
  String get formattedTimestamp => widget.timestamp.toDate().toString();
  late Employer employer;
  late JobApplication jobApplication;
  late JobPostModel jobPost;
  final UserRepo = UserRepository.Instance;

  late NotificationsControllerJ controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(NotificationsControllerJ());
    fetchData();
  }

  fetchData() async {
    employer = await controller.fetchEmployerDetails(widget.employerId);
    jobApplication =
        await controller.fetchJobApplicationDetails(widget.jobApplicationId);
    jobPost = await controller.fetchJobPostDetails(jobApplication.JobPostId);
  }

  bool isNotificationNew() {
    final now = DateTime.now();
    final notificationTime = widget.timestamp.toDate();
    final difference = now.difference(notificationTime);
    return difference.inMinutes <= 10;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0,
      color: Color(0xffede9fa),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: controller.isLoading.value
              ? Lottie.asset("images/getting.json")
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(employer.CompanyLogo),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontFamily: 'Satoshi',
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        isNotificationNew()
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  "New",
                                  style: TextStyle(
                                    fontFamily: 'Satoshi',
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                    SizedBox(height: 6),
                    Text(
                      widget.content,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Satoshi',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () {
                            Get.to(() => JobApplicationDetails(
                                jobApplication: jobApplication,
                                jobPost: jobPost));
                          },
                          child: Text(
                            "See Details",
                            style: TextStyle(
                              fontFamily: 'Satoshi',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                              side: BorderSide(
                                color: Colors.black,
                                width: 0.8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(horizontal: 20)),
                        ),
                        Spacer(),
                        Text(
                          calculateTimeDifference(formattedTimestamp),
                          style: GoogleFonts.inter(
                            color: Color.fromARGB(255, 99, 98, 98),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
