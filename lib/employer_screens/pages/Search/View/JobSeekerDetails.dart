import 'package:MyJob/Models/Job_seeker/Job_seeker.dart';
import 'package:MyJob/employer_screens/pages/Search/Widgets/MoreDeatailsWidget.dart';
import 'package:MyJob/employer_screens/pages/Search/Widgets/headerWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobSeekerDetails extends StatelessWidget {
  final Job_seeker jobSeeker;
  const JobSeekerDetails({super.key, required this.jobSeeker});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1f1f1f),
      appBar: AppBar(
        backgroundColor: Color(0xff1f1f1f),
        title: Text(
          "${jobSeeker.name}",
          style: TextStyle(
            fontFamily: 'Satoshi',
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
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
      body: Padding(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderWidget(jobSeeker: jobSeeker),
              SizedBox(height: 10),
              MoreDetailsWidget(jobSeeker: jobSeeker),
            ],
          ),
        ),
      ),
    );
  }
}
