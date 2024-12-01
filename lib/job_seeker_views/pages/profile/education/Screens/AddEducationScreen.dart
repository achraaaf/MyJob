import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/pages/profile/education/Widgets/AddEducationForm.dart';
import 'package:google_fonts/google_fonts.dart';

class AddEducationScreen extends StatelessWidget {
  const AddEducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add education',
                style: GoogleFonts.dmSans(
                  color: Color(0xFF150B3D),
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 25),
              AddEducationForm()
            ],
          ),
        ),
      ),
    );
  }
}
