import 'package:MyJob/Helper/Data.dart';
import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/Controllers/JobSeekerController.dart';
import 'package:MyJob/job_seeker_views/JobSeekerNavigationBar.dart';
import 'package:MyJob/job_seeker_views/pages/profile/EditProfile/controller/editProfileController.dart';
import 'package:MyJob/utils/validators/SignUpValidation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class EditProfileForm extends StatefulWidget {
  final name;
  final city;
  final phone;

  const EditProfileForm({
    required this.name,
    required this.city,
    required this.phone,
    Key? key,
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
    controller.phoneController.text = widget.phone;
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
              'Nom complet',
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
              'Emplacement',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black.withOpacity(0.1),
              ),
              child: DropdownButton<String>(
                value: controller.cityController.text,
                borderRadius: BorderRadius.circular(15),
                focusColor: Colors.white,
                iconEnabledColor: Colors.black,
                underline: SizedBox.shrink(),
                items: Data.cities
                    .map((city) => DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    controller.cityController.text = value!;
                  });
                },
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Genre',
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
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: RadioListTile(
                      title: Text("Homme"),
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
                      color: Colors.black.withOpacity(0.1),
                    ),
                    child: RadioListTile(
                      title: Text("Femme"),
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
              'Numéro de téléphone',
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 5),
            TextField(controller.phoneController),
            SizedBox(height: 30),
            Center(
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.6,
                child: ElevatedButton(
                  onPressed: () {
                    controller.SaveChanges(context, _editprofileKey);
                    Navigator.pushReplacement(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRight,
                            child:
                                BottomNavigationBarJobseeker(wantedPage: 4)));
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    backgroundColor: Colors.black,
                  ),
                  child: Text(
                    'Enregistrer',
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
        fillColor: Colors.black.withOpacity(0.1),
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
