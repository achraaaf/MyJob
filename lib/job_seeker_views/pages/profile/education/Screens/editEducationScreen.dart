import 'package:flutter/material.dart';
import 'package:MyJob/Models/Job_seeker/education.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/utils/validators/educationValidator.dart';
import 'package:MyJob/job_seeker_views/pages/profile/education/controller/EducationController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class editEducationScreen extends StatefulWidget {
  final education Education;

  const editEducationScreen({super.key, required this.Education});

  @override
  State<editEducationScreen> createState() => _editEducationScreenState();
}

class _editEducationScreenState extends State<editEducationScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.put(EducationController());

  TextEditingController levelOfEducationController = TextEditingController();
  TextEditingController InstitutionNameController = TextEditingController();
  TextEditingController fieldOfStudyController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    levelOfEducationController.text = widget.Education.LevelofEducation;
    InstitutionNameController.text = widget.Education.InstitutionName;
    fieldOfStudyController.text = widget.Education.FieldOfStudy;
    startDateController.text = widget.Education.StartDate;
    endDateController.text = widget.Education.EndDate;
    descriptionController.text = widget.Education.Description;
  }

  @override
  void dispose() {
    levelOfEducationController.dispose();
    InstitutionNameController.dispose();
    fieldOfStudyController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    descriptionController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exactEducation = widget.Education.LevelofEducation;

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
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Change education',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  'Level of education ',
                  style: GoogleFonts.dmSans(
                    color: Color(0xFF150B3D),
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                TextField(
                    levelOfEducationController,
                    (Value) =>
                        educationValidator.LevelOfEducationValidator(Value)),
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
                TextField(
                    InstitutionNameController,
                    (Value) =>
                        educationValidator.InstitutionNameValidator(Value)),
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
                TextField(fieldOfStudyController,
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
                              startDateController,
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
                              endDateController,
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
                    controller: descriptionController,
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
                              exactEducation,
                              _formKey,
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
                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            Confirmation(
                                context, controller, exactEducation, _formKey,
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

  void Confirmation(BuildContext context, EducationController controller,
      String ExactEducation, GlobalKey<FormState> formKey,
      {bool isSaveConfirmation = true}) {
    String title;
    String description;
    String confirm;

    if (isSaveConfirmation) {
      title = 'Changes Saved ?';
      description = 'Are you sure you want to change what you entered?';
      confirm = "Yes save !";
    } else {
      title = 'Remove education?';
      description = 'Are you sure you want to delete this education?';
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

                      education Education = education(
                        LevelofEducation: levelOfEducationController.text,
                        FieldOfStudy: fieldOfStudyController.text,
                        InstitutionName: InstitutionNameController.text,
                        StartDate: startDateController.text,
                        EndDate: endDateController.text,
                        Description: descriptionController.text,
                      );

                      controller.updateEducation(ExactEducation, Education);
                    } else {
                      controller.deleteEducation(ExactEducation);
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
