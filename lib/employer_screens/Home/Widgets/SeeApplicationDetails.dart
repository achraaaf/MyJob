import 'dart:io';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/Models/Job_seeker/Job_seeker.dart';
import 'package:MyJob/Models/jobApplication/JobApplication.dart';
import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:MyJob/employer_screens/Home/Widgets/ConfirmationWidget.dart';
import 'package:MyJob/employer_screens/Home/Widgets/JobPostWidget.dart';
import 'package:MyJob/employer_screens/pages/Search/View/JobSeekerDetails.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class SeeApplicationDetails extends StatelessWidget {
  final Job_seeker jobSeeker;
  final JobApplication jobApplication;
  final JobPostModel jobPost;

  late final String companyName;
  late final String jobSalary;

  SeeApplicationDetails({
    Key? key,
    required this.jobSeeker,
    required this.jobApplication,
    required this.jobPost,
  }) : super(key: key) {
    companyName = EmployerController.instance.employer.value.companyName;
    final salary =
        double.tryParse(jobPost.jobSalary.replaceAll(RegExp(r'[^\d.]'), ''));
    jobSalary = '\$${(salary! ~/ 1000)}K /Month';
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f1f1f),
      appBar: AppBar(
        backgroundColor: Color(0xff1f1f1f),
        title: Text(
          "Details",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image(
            image: AssetImage("images/left-arrow.png"),
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Color(0xff2B2B2B),
                  borderRadius: BorderRadius.circular(24)),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff404040),
                        ),
                        child: Icon(
                          Iconsax.document_text,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Job Post",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  JobPostWidget(jobPost: jobPost, jobSalary: jobSalary),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Color(0xff2B2B2B),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 70,
                        width: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(jobSeeker.profilePicture),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Text(
                        jobSeeker.name,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Iconsax.location,
                              color: Colors.white,
                            ),
                            SizedBox(width: 5),
                            Text(
                              jobSeeker.city,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Get.to(() => JobSeekerDetails(jobSeeker: jobSeeker));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xff1f1f1f),
                              borderRadius: BorderRadius.circular(15)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Iconsax.more_circle,
                                color: Colors.white,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "More Details",
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Color(0xff2B2B2B),
                  borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff404040),
                        ),
                        child: Icon(
                          Iconsax.document,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Cv/resume",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  GestureDetector(
                    onTap: () async {
                      // download the file and open it
                      downloadAndOpenFilehhhh(jobApplication.resume);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff1f1f1f),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Image(
                            image: AssetImage(
                              "images/pdf.png",
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Download File",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Color(0xff2B2B2B),
                  borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff404040),
                        ),
                        child: Icon(
                          Iconsax.document_text,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Motivation Letter",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    jobApplication.MotivationLetter.trim() == ""
                        ? "No Motivation Letter"
                        : jobApplication.MotivationLetter.trim(),
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff2B2B2B),
                borderRadius: BorderRadius.circular(24),
              ),
              width: double.infinity,
              padding: EdgeInsets.all(15),
              child: jobApplication.status == "Pending"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Confirmation(context, jobApplication.id,
                                companyName, jobSeeker.id,jobPost.jobTitle,
                                isSaveConfirmation: true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Approve',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Confirmation(context, jobApplication.id,
                                companyName, jobSeeker.id,jobPost.jobTitle,
                                isSaveConfirmation: false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Text(
                            'Deny',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : jobApplication.status == "Approved"
                      ? Center(
                          child: Text(
                            "Application Approved",
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : Center(
                          child: Text(
                            "Application Rejected",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> downloadAndOpenFilehhhh(String url) async {
  try {
    Reference ref = FirebaseStorage.instance.refFromURL(url);

    final Directory tempDir = await getTemporaryDirectory();
    final String tempPath = tempDir.path;

    final String filePath = '$tempPath/${ref.name}';

    File file = File(filePath);
    await ref.writeToFile(file);

    OpenFile.open(filePath);
  } catch (e) {
    print('Error downloading or opening file: $e');
  }
}

Future<void> downloadAndOpenFile(BuildContext context, String url) async {
  try {
    Get.to(() => Loadingg());

    Directory? appDocDir = await getExternalStorageDirectory();
    String fileName = url.split('/').last.split('?').first;
    String savePath = '${appDocDir?.path}/$fileName';

    File file = File(savePath);
    if (!await file.exists()) {
      Dio dio = Dio();
      await dio.download(url, savePath);
    }

    Get.back();

    OpenFile.open(savePath);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Could not open the document'),
      ),
    );
  }
}

class Loadingg extends StatelessWidget {
  const Loadingg({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Please wait..."),
            SizedBox(height: 10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
