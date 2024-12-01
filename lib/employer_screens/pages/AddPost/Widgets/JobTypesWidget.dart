import 'package:MyJob/employer_screens/pages/AddPost/controller/AddPostController.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class JobTypesWidget extends StatelessWidget {
  const JobTypesWidget({
    super.key,
    required this.controller,
    required this.jobTypeIcons,
    required this.jobTypeDesciption,
  });

  final AddPostController controller;
  final Map<String, IconData> jobTypeIcons;
  final Map<String, String> jobTypeDesciption;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: (controller.jobTypes)
          .map((jobType) => InkWell(
                onTap: () {
                  if (controller.selectedJobTypes.contains(jobType)) {
                    controller.selectedJobTypes.remove(jobType);
                  } else {
                    controller.selectedJobTypes.add(jobType);
                  }
                },
                child: Container(
                  height: 120,
                  width: 110,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: controller.selectedJobTypes.contains(jobType)
                        ? Colors.black
                        : Colors.white,
                    border: Border.all(
                      color: Colors.grey.shade400,
                      width: 0.5,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        jobTypeIcons[jobType] ?? Icons.error,
                        color: controller.selectedJobTypes.contains(jobType)
                            ? Colors.white
                            : Colors.black,
                        size: 24.0,
                      ),
                      SizedBox(height: 3),
                      Text(
                        jobType,
                        style: GoogleFonts.dmSans(
                          color: controller.selectedJobTypes.contains(jobType)
                              ? Colors.white
                              : Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 3),
                      Text(
                        jobTypeDesciption[jobType] ?? '',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dmSans(
                          color: controller.selectedJobTypes.contains(jobType)
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
