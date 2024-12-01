import 'package:flutter/material.dart';
import 'package:MyJob/job_seeker_views/pages/profile/skills/view/addSkill.dart';
import 'package:MyJob/job_seeker_views/pages/profile/skills/controller/SkillsController.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class SearchBarView extends StatefulWidget {
  const SearchBarView({super.key});

  @override
  State<SearchBarView> createState() => _SearchBarViewState();
}

bool isAdded = false;

class _SearchBarViewState extends State<SearchBarView> {
  @override
  Widget build(BuildContext context) {
    final controller = SkillsController.instance;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 15),
          icon: Image(image: AssetImage("images/left-arrow.png")),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addSkill(),
              ),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => controller.filtreSkillsList(value),
              decoration: InputDecoration(
                  hintText: "Search skills",
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
                          builder: (context) => addSkill(),
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
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.filtredSkills.value.length,
                  itemBuilder: (context, index) {
                    final skill = controller.filtredSkills.value[index];
                    return Container(
                      margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 0.3,
                            blurRadius: 10,
                            offset: Offset(1, 0),
                          )
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          controller.filtredSkills.value[index],
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        onTap: () => controller.toggleSkill(skill),
                        trailing: Obx(
                          () => controller.getIconForSkill(skill),
                        ),
                        contentPadding: EdgeInsets.only(left: 20, right: 15),
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