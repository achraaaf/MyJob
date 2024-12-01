import 'package:flutter/material.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/Work_Experience/Controller/workExperienceController.dart';
import 'package:flutter_application_1/utils/validators/workExperienceValidator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class workExperienceForm extends StatelessWidget {
  const workExperienceForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(workExperienceController());
    return Form(
        key: controller.WorkExperienceFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text(
              'Job title',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            TextField(controller.JobTitle,
                (Value) => workExperienceValidator.JobTitleValidator(Value)),
            SizedBox(height: 10),
            Text(
              'Company',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            TextField(controller.Company,
                (Value) => workExperienceValidator.CompanyValidator(Value)),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date',
                        style: GoogleFonts.dmSans(
                          color: Color(0xFF150B3D),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextField(
                          controller.StartDate,
                          (Value) =>
                              workExperienceValidator.StartDateValidato(Value)),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Date',
                        style: GoogleFonts.dmSans(
                          color: Color(0xFF150B3D),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5),
                      TextField(
                          controller.EndDate,
                          (Value) =>
                              workExperienceValidator.EndDateValidato(Value)),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Description',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Container(
              height: MediaQuery.of(context).size.height * 0.18,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 73, 73, 73)
                    .withOpacity(0.10000000149011612),
                borderRadius: const BorderRadius.all(Radius.circular(13)),
              ),
              child: TextFormField(
                controller: controller.Description,
                style: TextStyle(
                  color: Colors.black,
                ),
                maxLines: null,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 7, left: 20),
                  hintText: 'Write additional information here',
                  hintStyle: GoogleFonts.dmSans(
                    color: Color.fromARGB(255, 97, 97, 97),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            SaveButton(context, controller),
          ],
        ));
  }

  Center SaveButton(BuildContext context, workExperienceController controller) {
    return Center(
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.6,
        child: ElevatedButton(
          onPressed: () {
            Map<String, dynamic> workExperienceData = {
              'title': controller.JobTitle.text,
              'company': controller.Company.text,
              'Start_date': controller.StartDate.text,
              'End_date': controller.EndDate.text,
              'description': controller.Description.text,
            };
            controller.addWorkExperience(context, workExperienceData);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.black,
          ),
          child: Text(
            'Save',
            style: GoogleFonts.dmSans(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 1),
          ),
        ),
      ),
    );
  }

  TextFormField TextField(TextEditingController controller, final Validate) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      validator: Validate,
      decoration: InputDecoration(
        border: InputBorder.none,
        hintStyle:
            const TextStyle(fontFamily: 'Futura', color: Color(0xFF3B3B3B)),
        filled: true,
        fillColor: Colors.black.withOpacity(0.10000000149011612),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(13)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(13)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(13)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(13)),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      ),
    );
  }
}
