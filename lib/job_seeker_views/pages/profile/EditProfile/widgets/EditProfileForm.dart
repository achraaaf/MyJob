import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controllers/JobSeekerController.dart';
import 'package:flutter_application_1/job_seeker_views/pages/profile/EditProfile/controller/editProfileController.dart';
import 'package:flutter_application_1/utils/validators/SignUpValidation.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileForm extends StatefulWidget {
  final name;
  final city;

  const EditProfileForm({
    required this.name,
    required this.city,
    super.key,
  });

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

String? _gender = 'Male';

final GlobalKey<FormState> _editprofileKey = GlobalKey<FormState>();
final JobSeekerData = JobSeekerController.instance;
final controller = editProfileController.instance;

class _EditProfileFormState extends State<EditProfileForm> {
  void initState() {
    super.initState();
    controller.nameController.text = widget.name;
    controller.cityController.text = widget.city;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _editprofileKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
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
            SizedBox(height: 10),
            Text(
              'Date of birthday',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            TextField(controller.DateBirthday),
            SizedBox(height: 10),
            Text(
              'Gender',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(0.10000000149011612),
                    ),
                    child: RadioListTile(
                      title: Text("Male"),
                      value: "Male",
                      groupValue: _gender,
                      onChanged: (val) {
                        setState(() {
                          _gender = val;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.black.withOpacity(0.10000000149011612),
                    ),
                    child: RadioListTile(
                      title: Text("Female"),
                      value: "Female",
                      groupValue: _gender,
                      onChanged: (val) {
                        setState(() {
                          _gender = val;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Phone Number',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            TextField(controller.phoneController),
            SizedBox(height: 10),
            Text(
              'Location',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            TextField(controller.cityController,
                validator: (Value) => Validation.ValidateLocation(Value)),
            SizedBox(height: 30),
            Center(
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    controller.SaveChanges(context, _editprofileKey);
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
            ),
            SizedBox(height: 20)
          ],
        ),
      ),
    );
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
