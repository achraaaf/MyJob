import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class JobCategoryWidget extends StatelessWidget {
  const JobCategoryWidget({
    super.key,
    required this.controller,
  });

  final controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        width: MediaQuery.of(context).size.width * 0.7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.grey.shade200,
        ),
        child: DropdownButton<String>(
          borderRadius: BorderRadius.circular(15),
          focusColor: Colors.white,
          value: controller.JobCategoryController.value,
          style: TextStyle(color: Colors.white),
          iconEnabledColor: Colors.black,
          underline: SizedBox.shrink(),
          isExpanded: true,
          items: <String>[
            'Computer & IT',
            'Business & Finance',
            'Creative & Design',
            'Marketing',
            'Education & Training',
            'Engineering',
            'Media & Communications',
            'Healthcare',
            'Human Services',
            'Legal & Finance'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  letterSpacing: -0.5,
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newCategory) {
            controller.JobCategoryController.value = newCategory!;
          },
        ),
      ),
    );
  }
}
