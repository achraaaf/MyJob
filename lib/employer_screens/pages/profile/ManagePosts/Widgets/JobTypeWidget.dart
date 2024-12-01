import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class JobTypeWidget extends StatelessWidget {
  const JobTypeWidget({
    super.key,
    required this.controller,
  });

  final controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        runSpacing: 10,
        children: List.generate(
          controller.jobTypes.length,
          (index) {
            final jobType = controller.jobTypes[index];
            return InkWell(
              onTap: () {
                if (controller.selectedJobTypes.contains(jobType)) {
                  controller.selectedJobTypes.remove(jobType);
                } else {
                  controller.selectedJobTypes.add(jobType);
                }
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: controller.selectedJobTypes.contains(jobType)
                        ? Colors.black
                        : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  jobType,
                  style: GoogleFonts.dmSans(
                    color: controller.selectedJobTypes.contains(jobType)
                        ? Colors.white
                        : Colors.black,
                    letterSpacing: -0.5,
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
