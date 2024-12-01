import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/pages/profile/languages/Controller/LanguagesConroller.dart';
import 'package:MyJob/job_seeker_views/pages/profile/languages/View/LanguagesView.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class AddLanguage extends StatelessWidget {
  AddLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = LanguagesConroller.instance;
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add language",
              style: GoogleFonts.dmSans(
                color: Color(0xFF150B3D),
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => controller.filterLanguages(value),
              decoration: InputDecoration(
                  hintText: "Search Languages",
                  hintStyle: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(Iconsax.search_normal),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Languages(),
                        ),
                      );
                    },
                    child: Icon(Icons.close),
                  ),
                  filled: true,
                  fillColor: Colors.black.withOpacity(0.10000000149011612),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(13)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(13)),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 15)),
            ),
            SizedBox(height: 15),
            Obx(
              () => Expanded(
                child: ListView.builder(
                  itemCount: controller.filteredLanguages.length,
                  itemBuilder: (context, index) {
                    final languageName = controller.filteredLanguages[index];
                    final languageCode = controller.allLanguages.keys
                        .firstWhere((code) =>
                            controller.allLanguages[code] == languageName);
                    return Container(
                      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: ListTile(
                        leading: Image(
                          image: AssetImage(
                            "assets/Flags/$languageCode.png",
                          ),
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.language),
                        ),
                        title: Text(
                          languageName,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onTap: () => controller.toggleLanguage(languageName),
                        trailing:
                            Obx(() => controller.getIconForSkill(languageName)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
