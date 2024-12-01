import 'package:MyJob/Helper/Data.dart';
import 'package:MyJob/Models/Employer/Employer.dart';
import 'package:MyJob/employer_screens/Controller/EmployerController.dart';
import 'package:MyJob/employer_screens/pages/profile/editProfile/controller/editProfileController.dart';
import 'package:MyJob/utils/validators/SignUpValidation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class EditProfileForm extends StatefulWidget {
  final Employer employer;
  const EditProfileForm({super.key, required this.employer});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final Employercontroller = EmployerController.instance;
  final controller = editProfileController.instance;

  @override
  void initState() {
    super.initState();
    controller.companyName.text = widget.employer.companyName;
    controller.city.text = widget.employer.city;
    controller.Industry.text = widget.employer.Industry;
    controller.companyDescription.text = widget.employer.description;
    controller.companySize.text = widget.employer.companySize;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.editProfileFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Company Name',
            style: GoogleFonts.dmSans(
              color: Color(0xFF150B3D),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          TextField(controller.companyName,
              validator: (value) =>
                  Validation.ValidateField("Company Name", value)),
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
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black.withOpacity(0.10000000149011612),
            ),
            width: MediaQuery.of(context).size.width - 50,
            child: Row(
              children: [
                Icon(Iconsax.location),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: controller.city.text,
                  borderRadius: BorderRadius.circular(15),
                  focusColor: Colors.white,
                  iconEnabledColor: Colors.black,
                  underline: SizedBox.shrink(),
                  items: Data.cities
                      .map((city) => DropdownMenuItem<String>(
                            value: city,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width - 150,
                              child: FittedBox(
                                alignment: Alignment.topLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(city),
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      controller.city.text = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Industry',
            style: GoogleFonts.dmSans(
              color: Color(0xFF150B3D),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black.withOpacity(0.10000000149011612),
            ),
            child: Row(
              children: [
                Icon(Iconsax.brifecase_tick),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: controller.Industry.text,
                  borderRadius: BorderRadius.circular(15),
                  focusColor: Colors.white,
                  iconEnabledColor: Colors.black,
                  underline: SizedBox.shrink(),
                  items: Data.Industries.map(
                    (industry) => DropdownMenuItem<String>(
                      value: industry,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width - 130,
                        child: FittedBox(
                          alignment: Alignment.topLeft,
                          fit: BoxFit.scaleDown,
                          child: Text(industry),
                        ),
                      ),
                    ),
                  ).toList(),
                  onChanged: (value) {
                    setState(() {
                      controller.Industry.text = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Company size',
            style: GoogleFonts.dmSans(
              color: Color(0xFF150B3D),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Colors.black.withOpacity(0.10000000149011612),
            ),
            width: 280,
            child: Row(
              children: [
                Icon(Iconsax.building),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: controller.companySize.text,
                  borderRadius: BorderRadius.circular(15),
                  focusColor: Colors.white,
                  iconEnabledColor: Colors.black,
                  underline: SizedBox.shrink(),
                  items: <String>[
                    '1 - 10 Employees',
                    '10 - 50 Employees',
                    '50 - 100 Employees',
                    '100 - 500 Employees',
                    '500 - 1000 Employees',
                    '+1000 Employees',
                  ]
                      .map(
                        (industry) => DropdownMenuItem<String>(
                          value: industry,
                          child: Text(industry),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      controller.companySize.text = value!;
                    });
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          Text(
            'About Company',
            style: GoogleFonts.dmSans(
              color: Color(0xFF150B3D),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 73, 73, 73)
                  .withOpacity(0.10000000149011612),
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
            child: TextFormField(
              style: TextStyle(
                color: Colors.black,
              ),
              maxLines: null,
              controller: controller.companyDescription,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 7, left: 20),
                hintText: 'Tell us about the company',
                hintStyle: GoogleFonts.openSans(
                  color: Color.fromARGB(255, 97, 97, 97),
                ),
              ),
              maxLength: 175,
            ),
          ),
          SizedBox(height: 100)
        ],
      ),
    );
  }

  TextFormField TextField(TextEditingController controller, {final validator}) {
    return TextFormField(
      style: TextStyle(
        color: Colors.black,
      ),
      validator: validator,
      controller: controller,
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
