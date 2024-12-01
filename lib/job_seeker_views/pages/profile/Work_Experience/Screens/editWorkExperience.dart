import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:MyJob/Models/Job_seeker/workExperience.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/profile/Work_Experience/Controller/workExperienceController.dart';
import 'package:get/get.dart';
import 'package:MyJob/utils/validators/workExperienceValidator.dart';

import 'package:google_fonts/google_fonts.dart';

class editWorkExperience extends StatefulWidget {
  final workExperience WorkExperience;
  editWorkExperience({super.key, required this.WorkExperience});

  @override
  State<editWorkExperience> createState() => _editWorkExperienceState();
}

class _editWorkExperienceState extends State<editWorkExperience> {
  final controller = Get.put(workExperienceController());

  final TextEditingController JobTitle = TextEditingController();
  final TextEditingController Company = TextEditingController();
  final TextEditingController StartDate = TextEditingController();
  final TextEditingController EndDate = TextEditingController();
  final TextEditingController Description = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Company.text = widget.WorkExperience.companyName;
    JobTitle.text = widget.WorkExperience.title;
    StartDate.text = widget.WorkExperience.startDate;
    EndDate.text = widget.WorkExperience.endDate;
    Description.text = widget.WorkExperience.description;
  }

  @override
  void dispose() {
    JobTitle.dispose();
    Company.dispose();
    StartDate.dispose();
    EndDate.dispose();
    Description.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exactWorkExperience = widget.WorkExperience.title;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          icon: Image(image: AssetImage("images/left-arrow.png")),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change work experience',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Job title',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                TextForm(
                    JobTitle,
                    (Value) =>
                        workExperienceValidator.JobTitleValidator(Value)),
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
                TextForm(Company,
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
                          TextForm(
                              StartDate,
                              (Value) =>
                                  workExperienceValidator.StartDateValidato(
                                      Value)),
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
                          TextForm(
                              EndDate,
                              (Value) =>
                                  workExperienceValidator.EndDateValidato(
                                      Value)),
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
                    controller: Description,
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
                            Confirmation(context, controller,
                                exactWorkExperience, formKey,
                                isSaveConfirmation: false);
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
                            Confirmation(context, controller,
                                exactWorkExperience, formKey,
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
          ),
        ),
      ),
    );
  }

  TextFormField TextForm(TextEditingController controller, final Validate) {
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

  void Confirmation(BuildContext context, workExperienceController controller,
      String ExactWorkExperience, final formKey,
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
                      // check if the form is valid
                      if (!formKey.currentState!.validate()) {
                        return;
                      }
                      workExperience WorkExperience = workExperience(
                        companyName: JobTitle.text,
                        title: JobTitle.text,
                        startDate: StartDate.text,
                        endDate: EndDate.text,
                        description: Description.text,
                      );
                      controller.updateWorkExperience(
                          context, ExactWorkExperience, WorkExperience);
                    } else {
                      controller.deleteWorkExperience(
                          context, ExactWorkExperience);
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
                    backgroundColor: Colors.black,
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
}
