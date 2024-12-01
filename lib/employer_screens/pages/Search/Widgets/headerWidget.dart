import 'package:MyJob/Models/Job_seeker/Job_seeker.dart';
import 'package:MyJob/Repositories/Chat/chatRepository.dart';
import 'package:MyJob/Repositories/authentication/authentication_Repository.dart';
import 'package:MyJob/employer_screens/Employer_Home.dart';
import 'package:MyJob/employer_screens/pages/Messages/View/ChatPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({
    super.key,
    required this.jobSeeker,
  });

  final Job_seeker jobSeeker;
  final chatRepo = Get.put(ChatRepository());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 30,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Color(0xff2B2B2B),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(jobSeeker.profilePicture),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Text(
                jobSeeker.name,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(
                      Iconsax.location,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5),
                    Text(
                      jobSeeker.city,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  await chatRepo.createChatConversation(
                      jobSeekerId: jobSeeker.id,
                      employerId:
                          AuthenticationRepository.instance.authUser!.uid);
                  Get.to(() => employer_HomeScreen(wantedPage: 3));

                  final conversation = await chatRepo.getChatConversation(
                      jobSeekerId: jobSeeker.id,
                      employerId:
                          AuthenticationRepository.instance.authUser!.uid);
                  Get.to(() => ChatPage(
                      conversation: conversation, JobSeeker: jobSeeker));
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff1f1f1f),
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  child: Row(
                    children: [
                      Icon(
                        Iconsax.message_notif,
                        color: Colors.white,
                      ),
                      SizedBox(width: 5),
                      Text(
                        "Message",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
