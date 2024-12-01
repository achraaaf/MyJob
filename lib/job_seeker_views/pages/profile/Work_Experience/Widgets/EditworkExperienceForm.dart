import 'package:flutter/material.dart';
import 'package:flutter_application_1/job_seeker_views/job_seeker_Home.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/Work_Experience/Controller/workExperienceController.dart';
import 'package:get/get.dart';
import 'package:flutter_application_1/utils/validators/workExperienceValidator.dart';

import 'package:google_fonts/google_fonts.dart';

class EditworkExperienceForm extends StatelessWidget {
  final String jobTitle;
  final String company;
  final String start_date;
  final String end_date;
  final String description;
  const EditworkExperienceForm(
      {super.key,
      required this.jobTitle,
      required this.company,
      required this.start_date,
      required this.end_date,
      required this.description});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(workExperienceController());
    controller.Company.text = company;
    controller.JobTitle.text = jobTitle;
    controller.StartDate.text = start_date;
    controller.EndDate.text = end_date;
    controller.Description.text = description;

    final exactWorkExperience = jobTitle;
    return Form(
      key: controller.WorkExperienceFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          SizedBox(height: 30),
          Row(
            children: [
              // ========================= Remove ====================
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Confirmation(
                        context,
                        controller,
                        exactWorkExperience,
                        isSaveConfirmation: false,
                      );
                    },
                    child: Text(
                      'Remove',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Color(0xFFD6CDFE),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15),

              // ========================== save =======================
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(bottom: 8),
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () {
                      Confirmation(context, controller, exactWorkExperience,
                          isSaveConfirmation: true);
                    },
                    child: Text(
                      'Save',
                      style: GoogleFonts.dmSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      backgroundColor: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(13)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide.none, borderRadius: BorderRadius.circular(13)),
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

void Confirmation(BuildContext context, workExperienceController controller,
    String ExactWorkExperience,
    {bool isSaveConfirmation = true}) {
  String title;
  String description;
  String confirm;

  if (isSaveConfirmation) {
    title = 'Changes Saved ?';
    description = 'Are you sure you want to change what you entered?';
    confirm = "Yes save !";
  } else {
    title = 'Remove work experience?';
    description = 'Are you sure you want to delete this work experience?';
    confirm = "Yes Delete !";
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
              height: 60,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  if (isSaveConfirmation) {
                    controller.updateWorkExperience(
                        context, ExactWorkExperience);
                  } else {
                    //deleteWorkExperience();
                  }
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            BottomNavigationBarJobseeker(wantedPage: 4)),
                  );
                },
                child: Text(
                  confirm,
                  style: GoogleFonts.dmSans(
                      color: Colors.white,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.black,
                ),
              ),
            ),
            Container(
              height: 60,
              width: MediaQuery.of(context).size.width * 0.6,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel !',
                  style: GoogleFonts.dmSans(
                      color: Colors.black,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Color(0xFFD7CDFF),
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
