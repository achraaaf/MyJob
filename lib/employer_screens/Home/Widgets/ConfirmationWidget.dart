import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/employer_screens/Home/view/NotificationsView.dart';
import 'package:MyJob/utils/Loading/LoadingPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void Confirmation(BuildContext context, String jobApplicationId,
    String CompanyName, String JobSeekerId, String jobTitle,
    {bool isSaveConfirmation = true}) {
  String title;
  String description;
  String confirm;

  if (isSaveConfirmation) {
    title = 'Approve This Candidate ';
    description = 'Are sure you want to approve this candidate?';
    confirm = "Yes Approve !";
  } else {
    title = 'Deny This Candidate';
    description = 'Are sure you want to deny this candidate?';
    confirm = 'Yes Deny !';
  }

  showModalBottomSheet(
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
              title,
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              description,
              style: GoogleFonts.poppins(
                color: Color(0xFF514A6B),
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () async {
                  if (isSaveConfirmation) {
                    await ApproveJobApplication(
                        jobApplicationId, CompanyName, JobSeekerId, jobTitle);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationsView()));
                    Get.snackbar("Success", "Job Application Approved",
                        backgroundColor: Colors.green, colorText: Colors.white);
                  } else {
                    await DenyJobApplication(
                        jobApplicationId, CompanyName, JobSeekerId, jobTitle);
                    Navigator.pop(context);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NotificationsView()),
                    );
                    Get.snackbar("Success", "Job Application Denied",
                        backgroundColor: Colors.green, colorText: Colors.white);
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  confirm,
                  style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 18,
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
              height: 55,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel !',
                  style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 18,
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

Future<void> ApproveJobApplication(String JobApplicationId, String CompanyName,
    String jobSeekerId, String JobTitle) async {
  try {
    Get.to(() => LoadingPage());
    await FirebaseFirestore.instance
        .collection("applicationJobs")
        .doc(JobApplicationId)
        .update({
      "status": "Approved",
    });

    await FirebaseFirestore.instance
        .collection("notifications")
        .doc(jobSeekerId)
        .collection("Allnotifications")
        .add({
      "title": "Application Approved",
      "content":
          "Congratulations! Your application for the $JobTitle position at $CompanyName has been approved.",
      "recipient_id": jobSeekerId,
      "sender_id": AuthenticationRepository.instance.authUser!.uid,
      "application_id": JobApplicationId,
      "timestamp": Timestamp.now()
    });

    Get.back();
    Get.back();
  } on Exception {
    Get.snackbar("Error", "Something went wrong",
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}

Future<void> DenyJobApplication(String JobApplicationId, String CompanyName,
    String jobSeekerId, String JobTitle) async {
  try {
    Get.to(() => LoadingPage());

    await FirebaseFirestore.instance
        .collection("applicationJobs")
        .doc(JobApplicationId)
        .update({
      "status": "Rejected",
    });
    await FirebaseFirestore.instance
        .collection("notifications")
        .doc(jobSeekerId)
        .collection("Allnotifications")
        .add({
      "title": "Application Status Update",
      "content":
          "We regret to inform you that your application for the $JobTitle position at $CompanyName has been rejected. Thank you for your interest.",
      "recipient_id": jobSeekerId,
      "sender_id": AuthenticationRepository.instance.authUser!.uid,
      "application_id": JobApplicationId,
      "timestamp": Timestamp.now()
    });
    Get.back();
    Get.back();
  } on Exception {
    Get.snackbar("Error", "Something went wrong",
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}
