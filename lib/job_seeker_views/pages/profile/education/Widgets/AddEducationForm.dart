import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/profile/education/controller/EducationController.dart';
import 'package:MyJob/utils/validators/educationValidator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEducationForm extends StatefulWidget {
  AddEducationForm({super.key});

  @override
  State<AddEducationForm> createState() => _AddEducationFormState();
}

class _AddEducationFormState extends State<AddEducationForm> {
  final controller = Get.put(EducationController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            Text(
              'Level of education ',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            TextField(controller.levelOfEducationController,
                (Value) => educationValidator.LevelOfEducationValidator(Value)),
            SizedBox(height: 10),
            Text(
              'Institution name',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            TextField(controller.InstitutionNameController,
                (Value) => educationValidator.InstitutionNameValidator(Value)),
            SizedBox(height: 10),
            Text(
              'Field of study',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            TextField(controller.fieldOfStudyController,
                (Value) => educationValidator.FieldOfStudy(Value)),
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
                          controller.startDateController,
                          (Value) =>
                              educationValidator.StartDateValidator(Value)),
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
                          controller.endDateController,
                          (Value) =>
                              educationValidator.EndDateValidator(Value)),
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
                controller: controller.descriptionController,
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

  Center SaveButton(BuildContext context, EducationController controller) {
    return Center(
      child: Container(
        height: 60,
        width: MediaQuery.of(context).size.width * 0.6,
        child: ElevatedButton(
          onPressed: () {
            Map<String, dynamic> educationData = {
              'LevelofEducation': controller.levelOfEducationController.text,
              'InstitutionName': controller.InstitutionNameController.text,
              'FieldOfStudy': controller.fieldOfStudyController.text,
              'Start_date': controller.startDateController.text,
              'End_date': controller.endDateController.text,
              'description': controller.descriptionController.text,
            };
            controller.addEducation(educationData, _formKey);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    BottomNavigationBarJobseeker(wantedPage: 4),
              ),
            );
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
