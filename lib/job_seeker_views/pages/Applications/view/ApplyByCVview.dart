import 'package:flutter/material.dart';
import 'package:MyJob/Models/JobPosts/JobPostModel.dart';
import 'package:MyJob/job_seeker_views/pages/Applications/controller/ApplyWithCVcontroller.dart';
import 'package:MyJob/utils/validators/SignUpValidation.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';

class ApplyWithCVview extends StatelessWidget {
  final JobPostModel jobPost;
  final GlobalKey<FormState> applyWithCVFormKey;

  ApplyWithCVview(
      {required this.jobPost, super.key, required this.applyWithCVFormKey});


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ApplyWithCVcontroller());
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Apply with CV",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image(
            image: AssetImage("images/left-arrow.png"),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
              key: applyWithCVFormKey,
              child: Obx(() {
                if (controller.isLoading.value)
                  return SizedBox(
                    width: 500,
                    height: 500,
                    child: Lottie.asset("images/getting.json"),
                  );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Full Name',
                      style: GoogleFonts.dmSans(
                        color: Color(0xFF150B3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextField(controller.nameController,
                        validator: (Value) => Validation.ValidateName(Value)),
                    SizedBox(height: 13),
                    Text(
                      'Email',
                      style: GoogleFonts.dmSans(
                        color: Color(0xFF150B3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    TextField(controller.emailController,
                        validator: (Value) => Validation.ValidateEmail(Value)),
                    SizedBox(height: 13),
                    Text(
                      'Upload CV/Resume',
                      style: GoogleFonts.dmSans(
                        color: Color(0xFF150B3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 13),
                    Obx(
                      () => controller.hasCV // Use Obx for reactive updates
                          ? ListTile(
                              leading:
                                  getFileTypeIcon(controller.cvFileExtension),
                              title: Text(controller.cvFileName!),
                              subtitle: Text(controller.cvFileSize!),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: controller.removeCV,
                              ),
                              tileColor:
                                  Colors.black.withOpacity(0.10000000149011612),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding:
                                  EdgeInsets.only(top: 5, bottom: 5, left: 10),
                            )
                          : Container(
                              height: 100,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.black
                                      .withOpacity(0.10000000149011612)),
                              child: InkWell(
                                onTap: () async {
                                  controller.uploadCV();
                                },
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Iconsax.document_upload5,
                                        color: Color(0xff246bfd),
                                        size: 40,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        'Browse File',
                                        style: GoogleFonts.dmSans(
                                          color: Color(0xFF150B3D),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 13),
                    Text(
                      'Motivation letter (optional)',
                      style: GoogleFonts.dmSans(
                        color: Color(0xFF150B3D),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 7),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.18,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 73, 73, 73)
                            .withOpacity(0.10000000149011612),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(13)),
                      ),
                      child: TextFormField(
                        controller: controller.motivationLetterController,
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        maxLines: null,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 7, left: 20),
                          hintText: 'Motivation letter...',
                          hintStyle: GoogleFonts.dmSans(
                            color: Color.fromARGB(255, 97, 97, 97),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Container(
                        height: 55,
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: ElevatedButton(
                          onPressed: () {
                            controller.submit(
                                jobPost, context, applyWithCVFormKey);
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            backgroundColor: Colors.black,
                          ),
                          child: Text(
                            'Submit',
                            style: GoogleFonts.dmSans(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              })),
        ),
      ),
    );
  }

  Widget getFileTypeIcon(String? extension) {
    switch (extension?.toLowerCase()) {
      case 'pdf':
        return Image(image: AssetImage("images/pdf.png"));
      default:
        return Image(image: AssetImage("images/docs.png")); // Default icon
    }
  }

  TextFormField TextField(TextEditingController controller, {final validator}) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        border: InputBorder.none,
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
